#################################
# EFS for pgAdmin (and Marquez) #
#################################

module "efs" {
  source = "../modules/efs"

  name       = local.prefix
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids
  tags       = local.tags

  # Create an SG that allows NFS (2049) from the VPC CIDR automatically.
  create_security_group = true

  # Define multiple access points so this single EFS can serve more apps.
  access_points = [
    {
      name        = "pgadmin"
      path        = "/pgadmin"
      uid         = 5050 # adjust if your container user differs
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
