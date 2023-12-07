
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
  type = map(object({
    org           = string
    repository    = optional(string)
    labels        = optional(string)
    runner_prefix = optional(string)
  }))
}

variable "secret_name" {
  type    = string
  default = "github-token"
}
