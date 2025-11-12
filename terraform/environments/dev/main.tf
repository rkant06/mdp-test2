terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket         = "mdp-terraform"  
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = "dev"
      ManagedBy   = "Terraform"
      Project     = "mdp"
    }
  }
}

# Data Lake S3 Bucket
module "quarantine_zone" {
  source = "../../modules/s3"

  bucket_name = "${var.project_name}-${var.environment}-quarantine-zone"
  environment = var.environment
}

