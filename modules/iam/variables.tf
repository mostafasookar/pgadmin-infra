variable "name" {
  type        = string
  description = "Base name prefix for IAM roles"
  default     = "pgadmin"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to IAM roles"
  default     = {}
}
