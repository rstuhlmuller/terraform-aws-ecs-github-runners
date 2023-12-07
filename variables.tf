
variable "force_image_rebuild" {
  type    = bool
  default = false
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "runner_token" {
  type      = string
  sensitive = true
}

variable "runner_prefix" {
  type    = string
  default = "aws-ecs-github-runner"
}

variable "github_owner" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "labels" {
  type = string
}

variable "secret_name" {
  type    = string
  default = "aws-ecs-github-runner-token"
}

variable "service_name" {
  type    = string
  default = "github-runner"
}

variable "secret_arn_override" {
  type = string
}