#############################
# CodeDeploy ECS Application
#############################

resource "aws_codedeploy_app" "this" {
  name             = "${var.name}-ecs-app"
  compute_platform = "ECS"
  tags             = local.common_tags
}

#############################
# CodeDeploy ECS Deployment Group
#############################

resource "aws_codedeploy_deployment_group" "this" {
  app_name               = aws_codedeploy_app.this.name
  deployment_group_name  = "${var.name}-ecs-dg"
  service_role_arn       = var.codedeploy_role_arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  tags = local.common_tags
}
