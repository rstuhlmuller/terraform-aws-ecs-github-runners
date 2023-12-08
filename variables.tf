
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
  default   = ""
}

variable "cluster_name" {
  type    = string
  default = "Self-Hosted-Github-Runners"
}

variable "secret_arn_override" {
  type    = string
  default = null
  validation {
    condition     = can(regex("^arn:aws:secretsmanager:[a-z0-9-]+:[0-9]{12}:secret:.+", var.secret_arn_override))
    error_message = "Please enter a valid secrets manager ARN for the secret_arn_override variable."
  }
}

variable "runners" {
  type    = any
  default = {}
}

variable "default_runner_config" {
  type = object({
    org                       = string
    labels                    = optional(string)
    runner_prefix             = optional(string)
    runner_group              = optional(string)
    scale_target_min_capacity = optional(number)
    scale_target_max_capacity = optional(number)
    min_cpu_period            = optional(number)
    max_cpu_threshold         = optional(number)
    min_cpu_threshold         = optional(number)
    max_cpu_evaluation_period = optional(number)
    min_cpu_evaluation_period = optional(number)
  })
  default = {
    org                       = ""
    labels                    = null
    runner_prefix             = "aws-ecs-github-runner"
    runner_group              = null
    scale_target_min_capacity = 1
    scale_target_max_capacity = 10
    min_cpu_period            = 10
    max_cpu_threshold         = 80
    min_cpu_threshold         = 10
    max_cpu_evaluation_period = 3
    min_cpu_evaluation_period = 3
  }
}

variable "secret_name" {
  type    = string
  default = "github-token"
}
