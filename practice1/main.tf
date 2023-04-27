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
  }
  required_version = ">= 1.1.0"

  # cloud {
  #   organization = "edge-green"

  #   workspaces {
  #     name = "terraform-practice-api"
  #   }
  # }

  # https://registry.terraform.io/providers/FlexibleEngineCloud/flexibleengine/latest/docs/guides/remote-state-backend
  #--------------------------------------------------------------------------------------------------------------------
  backend "s3" {
    bucket         = "terraform-practice-api-state-bucket"
    key            = "tf-backend/practice1/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-practice-api-state-table"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "organization" = "edge-green",
      "Workspaces"   = "terraform-practice-api",
      "Team"         = "DevOps",
      "DeployedBy"   = "Terraform",
      "OwnerEmail"   = "devops@example.com"
    }
  }
}
