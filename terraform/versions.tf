terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "pgadmin-terraform-state-test"
    key            = "pgadmin/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}
