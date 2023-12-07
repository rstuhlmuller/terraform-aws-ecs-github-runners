
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

# variable "runner_token" {
#   type      = string
#   sensitive = true
# }
