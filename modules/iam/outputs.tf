output "execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = aws_iam_role.execution_role.arn
}

output "task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.task_role.arn
}
