output "codedeploy_app_name" {
  value       = aws_codedeploy_app.this.name
  description = "CodeDeploy application name"
}

output "codedeploy_deployment_group_name" {
  value       = aws_codedeploy_deployment_group.this.deployment_group_name
  description = "CodeDeploy deployment group name"
}
