terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket = "portfolio-tfstate-194772390844"
    key    = "terraform.tfstate"
    region = "sa-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
