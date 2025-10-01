variable "name" {
  type        = string
  description = "Prefix for resources"
  default     = "pgadmin"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for endpoints (use private subnets usually)"
}

variable "sg_id" {
  type        = string
  description = "Security group to attach to endpoints"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
