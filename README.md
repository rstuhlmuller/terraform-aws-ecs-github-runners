# AWS ECS Github Runners Module

Terraform module which deploys autoscaling ECS taks in an AWS ECS cluster.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs-service-autoscaling"></a> [ecs-service-autoscaling](#module\_ecs-service-autoscaling) | git::https://github.com/cn-terraform/terraform-aws-ecs-service-autoscaling.git | 1e0eee4ed3f67e5465289055155d3b5b7d27eb35 |

## Resources

| Name | Type |
|------|------|
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
| <a name="input_default_runner_config"></a> [default\_runner\_config](#input\_default\_runner\_config) | n/a | <pre>object({<br>    org                       = string<br>    labels                    = optional(string)<br>    runner_prefix             = optional(string)<br>    runner_group              = optional(string)<br>    scale_target_min_capacity = optional(number)<br>    scale_target_max_capacity = optional(number)<br>    min_cpu_period            = optional(number)<br>    max_cpu_threshold         = optional(number)<br>    min_cpu_threshold         = optional(number)<br>  })</pre> | <pre>{<br>  "labels": null,<br>  "max_cpu_threshold": 80,<br>  "min_cpu_period": 10,<br>  "min_cpu_threshold": 10,<br>  "org": "",<br>  "runner_group": null,<br>  "runner_prefix": "aws-ecs-github-runner",<br>  "scale_target_max_capacity": 10,<br>  "scale_target_min_capacity": 1<br>}</pre> | no |
| <a name="input_force_image_rebuild"></a> [force\_image\_rebuild](#input\_force\_image\_rebuild) | n/a | `bool` | `false` | no |
| <a name="input_runner_token"></a> [runner\_token](#input\_runner\_token) | n/a | `string` | `""` | no |
| <a name="input_runners"></a> [runners](#input\_runners) | n/a | `any` | `{}` | no |
| <a name="input_secret_arn_override"></a> [secret\_arn\_override](#input\_secret\_arn\_override) | n/a | `string` | `null` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | n/a | `string` | `"github-token"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->