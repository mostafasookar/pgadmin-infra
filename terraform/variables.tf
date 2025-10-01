variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for pgAdmin deployment"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0acff19cbcdd28123"
  description = "Existing VPC ID"
}

variable "public_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0096b55bfec0fc1b7",
    "subnet-0baa7f08adef5addb",
    "subnet-03be7e34785dcc9ed"
  ]
  description = "Public subnets for ALB"
}

variable "private_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0f15865ff763a4cd2",
    "subnet-05fe1790c8745cf07",
    "subnet-05a98b6683351fe11"
  ]
  description = "Private subnets for ECS tasks and EFS mount targets"
}

variable "nated_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0c30e0a79884dfd82",
    "subnet-043c7e91ecd807a0c",
    "subnet-063f7cf49a5ac401c"
  ]
  description = "NAT subnets (optional, if needed for endpoints)"
}

variable "tags" {
  type    = map(string)
  default = { Project = "pgadmin" }
}
