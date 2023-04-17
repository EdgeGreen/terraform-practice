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

  backend "s3" {
    bucket         = "terraform-practice-api-state-bucket"
    key            = "tf-backend/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-practice-api-state-table"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
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