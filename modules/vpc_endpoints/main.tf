###########################
# VPC Interface Endpoints #
###########################

# ECR API
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [var.sg_id]
  private_dns_enabled = true
  tags = merge(local.common_tags, { Name = "${var.name}-ecr-api" })
}

# ECR DKR (image pulls)
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [var.sg_id]
  private_dns_enabled = true
  tags = merge(local.common_tags, { Name = "${var.name}-ecr-dkr" })
}

# CloudWatch Logs
resource "aws_vpc_endpoint" "logs" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [var.sg_id]
  private_dns_enabled = true
  tags = merge(local.common_tags, { Name = "${var.name}-logs" })
}

# Secrets Manager
resource "aws_vpc_endpoint" "secrets" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [var.sg_id]
  private_dns_enabled = true
  tags = merge(local.common_tags, { Name = "${var.name}-secrets" })
}

# SSM for ECS Exec
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [var.sg_id]
  private_dns_enabled = true
  tags = merge(local.common_tags, { Name = "${var.name}-ssm" })
}
