variable "name" {
  type        = string
  default     = "pgadmin"
  description = "Name prefix"
}

variable "cpu" {
  type        = string
  default     = "512"
  description = "Task CPU"
}

variable "memory" {
  type        = string
  default     = "1024"
  description = "Task Memory"
}

variable "container_port" {
  type        = number
  default     = 80
  description = "Port where pgAdmin listens"
}

variable "desired_count" {
  type        = number
  default     = 1
  description = "Number of tasks to run"
}

variable "execution_role_arn" {
  type        = string
  description = "ECS execution role ARN"
}

variable "task_role_arn" {
  type        = string
  description = "ECS task role ARN"
}

variable "ecr_repo_url" {
  type        = string
  description = "ECR repo URL for pgAdmin image"
}

variable "efs_id" {
  type        = string
  description = "EFS File System ID"
}

variable "efs_access_point_id" {
  type        = string
  description = "EFS Access Point ID for pgAdmin"
}

variable "ecs_sg_id" {
  type        = string
  description = "ECS Security Group ID"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnets for ECS tasks"
}

variable "pgadmin_secret_arn" {
  type        = string
  description = "Secrets Manager ARN for pgAdmin login"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags"
}
