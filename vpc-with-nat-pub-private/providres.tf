terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
  backend "s3" {
    bucket = "snoooooow"
    region = "ap-south-1"
    key    = "evening7pm.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
  #access_key = ""
  #secret_key = ""
}