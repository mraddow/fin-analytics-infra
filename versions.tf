terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    # Configure based on your setup
    bucket = "my-fin-terraform-state-bucket"
    key    = "financial-analytics/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "financial-analytics"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}