locals {
  ecr_repo  = "docker-runner-image" # ECR repo name
  image_tag = "latest"              # image tag

  dkr_img_src_path   = "${path.module}/docker-src"
  dkr_img_src_sha256 = sha256(join("", [for f in fileset(".", "${local.dkr_img_src_path}/**") : file(f)]))

  dkr_build_cmd    = <<-EOT
        docker build -t ${aws_ecr_repository.runner_image.repository_url}:${local.image_tag} ${local.dkr_img_src_path}

        aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com

        docker push ${aws_ecr_repository.runner_image.repository_url}:${local.image_tag}
    EOT
  github_token_arn = var.secret_arn_override == null ? aws_secretsmanager_secret.github_token[0].arn : var.secret_arn_override
}

resource "aws_ecr_repository" "runner_image" {
  name                 = local.ecr_repo
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "push_ecr" {
  triggers = {
    detect_docker_source_changes = var.force_image_rebuild == true ? timestamp() : local.dkr_img_src_sha256,
    aws_ecr_repository           = aws_ecr_repository.runner_image.repository_url
  }
  provisioner "local-exec" {
    command = local.dkr_build_cmd
  }
}

resource "aws_ecs_cluster" "github_runner_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "runner" {
  for_each             = var.runners
  name                 = each.key
  cluster              = aws_ecs_cluster.github_runner_cluster.id
  task_definition      = aws_ecs_task_definition.runner[each.key].arn
  desired_count        = 1
  launch_type          = "FARGATE"
  force_new_deployment = var.force_image_rebuild
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }
}

resource "aws_secretsmanager_secret" "github_token" {
  count = var.secret_arn_override == null ? 1 : 0
  name  = var.secret_name
}

resource "aws_secretsmanager_secret_version" "github_token" {
  count         = var.secret_arn_override == null ? 1 : 0
  secret_id     = aws_secretsmanager_secret.github_token[0].id
  secret_string = var.runner_token
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "aws-ecs-github-runner-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "aws-ecs-github-runners-role"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "SecretsManager"
          Effect = "Allow"
          Action = [
            "secretsmanager:GetSecretValue"
          ]
          Resource = "${regex("^arn:aws:secretsmanager:[a-z0-9-]+:[0-9]{12}:secret:[^:]+", local.github_token_arn)}"
        },
        {
          Sid    = "ECR"
          Effect = "Allow"
          Action = [
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken"
          ]
          Resource = "*"
        },
        {
          Sid    = "CloudWatchLogs"
          Effect = "Allow"
          Action = [
            "logs:CreateLogGroup",
            "logs:DeleteLogGroup",
            "logs:CreateLogStream",
            "logs:DeleteLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams"
          ]
          Resource = "arn:aws:logs:*:*:*"
        },
      ]
    })
  }
}

resource "aws_ecs_task_definition" "runner" {
  for_each                 = var.runners
  family                   = "${var.cluster_name}_${each.key}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024 * 1
  memory                   = 1024 * 3
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      "name" : "${each.key}",
      "image" : "${aws_ecr_repository.runner_image.repository_url}:${local.image_tag}",
      "portMappings" : [
        {
          "name" : "${lower(each.key)}-8080-tcp",
          "containerPort" : 8080,
          "hostPort" : 8080,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      "environment" : [
        {
          "name" : "RUNNER_PREFIX",
          "value" : "${each.value.runner_prefix}"
        },
        {
          "name" : "GH_OWNER",
          "value" : "${each.value.org}"
        },
        {
          "name" : "GH_REPOSITORY",
          "value" : "${each.value.repository}"
        },
        {
          "name" : "LABELS",
          "value" : "${each.value.labels}"
        }
      ]
      "secrets" : [
        {
          "name" : "GH_TOKEN",
          "valueFrom" : "${local.github_token_arn}"
        }
      ],
      "essential" : true,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/aws-ecs-github-runners",
          "awslogs-region" : "${data.aws_region.current.name}",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}
