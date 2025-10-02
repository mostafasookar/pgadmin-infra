#################################
# EFS for pgAdmin (and Marquez) #
#################################

module "efs" {
  source = "../modules/efs"

  name       = local.prefix
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids
  tags       = local.tags

  create_security_group = true

  access_points = [
    {
      name        = "pgadmin"
      path        = "/pgadmin"
      uid         = 5050
      gid         = 5050
      permissions = "750"
    },
    {
      name        = "marquez"
      path        = "/marquez"
      uid         = 1000
      gid         = 1000
      permissions = "750"
    }
  ]
}

###############
# ECR for App #
###############

module "ecr" {
  source = "../modules/ecr"

  name = "pgadmin"
  tags = local.tags
}

##############
# IAM Roles  #
##############

module "iam" {
  source = "../modules/iam"

  name = "pgadmin"
  tags = local.tags
}

###################
# Security Groups #
###################

module "security_groups" {
  source = "../modules/security_groups"

  name           = "pgadmin"
  vpc_id         = var.vpc_id
  container_port = 80
  tags           = local.tags
}

########################
# Secrets for pgAdmin  #
########################

module "secrets" {
  source = "../modules/secrets"

  name             = "pgadmin"
  pgadmin_email    = "admin@example.com"
  pgadmin_password = "SuperSecretPassword!"
  tags             = local.tags
}

###############
# ECS Service #
###############

module "ecs" {
  source = "../modules/ecs"

  name                 = "pgadmin"
  execution_role_arn   = module.iam.execution_role_arn
  task_role_arn        = module.iam.task_role_arn
  ecr_repo_url         = module.ecr.repository_url
  efs_id               = module.efs.file_system_id
  efs_access_point_id  = module.efs.access_point_ids_by_name["pgadmin"]
  ecs_sg_id            = module.security_groups.ecs_sg_id
  alb_target_group_arn = module.alb.target_group_arn
  private_subnet_ids   = var.private_subnet_ids
  public_subnet_ids    = var.public_subnet_ids
  pgadmin_secret_arn   = module.secrets.pgadmin_secret_arn
  region               = var.region
  tags                 = local.tags
}

###################
# Application LB  #
###################

module "alb" {
  source = "../modules/alb"

  name              = "pgadmin"
  vpc_id            = var.vpc_id
  public_subnet_ids = var.public_subnet_ids
  sg_id             = module.security_groups.ecs_sg_id
  container_port    = 80
  tags              = local.tags
}

###################################
# ECS Autoscaling for pgAdmin     #
###################################

module "pgadmin_autoscaling" {
  source       = "../modules/autoscaling"
  name         = "pgadmin"
  cluster_name = module.ecs.ecs_cluster_name
  service_name = module.ecs.ecs_service_name

  min_capacity        = 1
  max_capacity        = 3
  cpu_target_value    = 70
  memory_target_value = 75
  tags                = local.tags
}

###################################
# CloudWatch alerts for pgAdmin   #
###################################

module "pgadmin_cloudwatch" {
  source       = "../modules/cloudwatch"
  name         = "pgadmin"
  cluster_name = module.ecs.ecs_cluster_name
  service_name = module.ecs.ecs_service_name
  alert_email  = "mm_soso33@yahoo.com"

  cpu_alarm_threshold    = 80
  memory_alarm_threshold = 85
  tags                   = local.tags
}

######################
# VPC Endpoints (VPCE)
######################
module "vpc_endpoints" {
  source = "../modules/vpc_endpoints"

  name                    = "pgadmin"
  vpc_id                  = var.vpc_id
  region                  = var.region
  subnet_ids              = var.private_subnet_ids
  sg_id                   = null # set to module.security_groups.ecs_sg_id if you want to reuse ECS SG; else module creates one
  private_route_table_ids = var.private_route_table_ids
  tags                    = local.tags
}
