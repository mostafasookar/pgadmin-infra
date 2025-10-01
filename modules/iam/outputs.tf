output "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_role_arn" {
  description = "ECS Task Role ARN"
  value       = aws_iam_role.ecs_task.arn
}

output "codedeploy_role_arn" {
  description = "CodeDeploy Role ARN"
  value       = aws_iam_role.codedeploy.arn
}
