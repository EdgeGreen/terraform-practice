terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  backend "s3" {
    bucket         = var.s3_bucket_name
    key            = "tf-backend/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = var.dynamodb_table_name
    encrypt        = true
  }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "edge-green"

    workspaces {
      name = "terraform-practice-api"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      "organization"     = "edge-green",
      "Workspaces"       = "terraform-practice-api",
      "Team"             = "DevOps",
      "DeployedBy"       = "Terraform",
      "OwnerEmail"       = "devops@example.com"
    }
  }
}