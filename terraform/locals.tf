locals {
  prefix = "pgadmin"
  tags   = merge({ ManagedBy = "Terraform" }, var.tags)
}
