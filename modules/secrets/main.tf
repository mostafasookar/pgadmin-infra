#############################
# Secrets for pgAdmin Login #
#############################

resource "aws_secretsmanager_secret" "pgadmin" {
  name        = "${var.name}-credentials"
  description = "Credentials for pgAdmin default login"
  tags        = merge(local.common_tags, { Name = "${var.name}-secrets" })
}

# Initial secret value (email + password)
# In practice, you might rotate these manually or via pipeline later
resource "aws_secretsmanager_secret_version" "pgadmin" {
  secret_id     = aws_secretsmanager_secret.pgadmin.id
  secret_string = jsonencode({
    PGADMIN_DEFAULT_EMAIL    = var.pgadmin_email
    PGADMIN_DEFAULT_PASSWORD = var.pgadmin_password
  })
}
