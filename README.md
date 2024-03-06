# AWS ECS Self-Hosted Github Runners Module

Terraform module which deploys autoscaling ECS taks in an AWS ECS cluster.

## Description
This repository contains infrastructure as code (IaC) for deploying GitHub Actions self-hosted runners on AWS ECS.

It creates the following resources:

- ECS cluster - Cluster to host the GitHub runner containers
- ECR repository - Stores the custom GitHub runner container image
- Dockerfile and scripts - Defines and builds the GitHub runner Docker image, pushes it to ECR
- Task definition - Defines the GitHub runner container to deploy
- ECS services - Runs the task definition as a service to maintain runner instances
- IAM roles and policies - Grants permissions for ECS agent and tasks
- Secrets Manager secret - Stores github token (can be overwritten)

The runners register themselves to a specified GitHub repository or organization automatically on boot. The number of runners can be adjusted by changing the desired count of the ECS service.

This enables GitHub Actions workloads to scale quickly by adding/removing containers without managing servers directly. Runners auto-update and register themselves, providing a hands-off GitHub runner management system.

The infrastructure is defined as code with HashiCorp Terraform and can be easily extended to other environments. Custom actions and parameters can be configured by modifying the included templates and variables.

## Usage

```hcl
module "aws_ecs_github_runner" {
  source = "git::https://github.com/rstuhlmuller/aws-ecs-github-runners.git?ref=main"

  cluster_name       = "Self-Hosted-Github-Runners"
  security_group_ids = ["<sg_1>"]
  subnet_ids = [
    "<subnet_1>",
    "<subnet_2>"
  ]

  runner_token = "<github_token with permissions to generate runner>"

  runners = {
    runner_1 = {
      org        = "My_Org"
      labels     = "aws,ecs,private"
    }
    runner_2 = {
      org        = "My_Org"
      labels     = "aws,ecs"
    }
  }

  providers = {
    aws = aws
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.29 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.29 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.scale_down_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.scale_up_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.scale_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_metric_alarm.cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecr_repository.runner_image](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.github_runner_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.runner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.runner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_secretsmanager_secret.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [null_resource.push_ecr](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"Self-Hosted-Github-Runners"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of CPUs for each runner | `number` | `1` | no |
| <a name="input_default_runner_config"></a> [default\_runner\_config](#input\_default\_runner\_config) | n/a | <pre>object({<br>    org                       = string<br>    labels                    = optional(string)<br>    runner_prefix             = optional(string)<br>    runner_group              = optional(string)<br>    scale_target_min_capacity = optional(number)<br>    scale_target_max_capacity = optional(number)<br>    min_cpu_period            = optional(number)<br>    max_cpu_period            = optional(number)<br>    max_cpu_threshold         = optional(number)<br>    min_cpu_threshold         = optional(number)<br>    max_cpu_evaluation_period = optional(number)<br>    min_cpu_evaluation_period = optional(number)<br>  })</pre> | <pre>{<br>  "labels": null,<br>  "max_cpu_evaluation_period": 3,<br>  "max_cpu_period": 120,<br>  "max_cpu_threshold": 80,<br>  "min_cpu_evaluation_period": 3,<br>  "min_cpu_period": 10,<br>  "min_cpu_threshold": 10,<br>  "org": "",<br>  "runner_group": null,<br>  "runner_prefix": "aws-ecs-github-runner",<br>  "scale_target_max_capacity": 10,<br>  "scale_target_min_capacity": 1<br>}</pre> | no |
| <a name="input_ecs_task_execution_role_name"></a> [ecs\_task\_execution\_role\_name](#input\_ecs\_task\_execution\_role\_name) | n/a | `string` | `"aws-ecs-github-runner-task-execution-role"` | no |
| <a name="input_force_image_rebuild"></a> [force\_image\_rebuild](#input\_force\_image\_rebuild) | n/a | `bool` | `false` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory in GB for each runner | `number` | `1` | no |
| <a name="input_runner_token"></a> [runner\_token](#input\_runner\_token) | n/a | `string` | `""` | no |
| <a name="input_runners"></a> [runners](#input\_runners) | n/a | `any` | `{}` | no |
| <a name="input_secret_arn_override"></a> [secret\_arn\_override](#input\_secret\_arn\_override) | n/a | `string` | `null` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | n/a | `string` | `"github-token"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Rodman Stuhlmuller](https://github.com/rstuhlmuller)

## License

MIT Licensed. See [LICENSE](https://github.com/rstuhlmuller/aws-ecs-github-runners/blob/main/LICENSE) for full details.