terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
  # backend "s3" {
  #   bucket = "snoooooow"
  #   region = "ap-south-1"
  #   key    = "evening7pm.tfstate"
  # }
  cloud { 
    
    organization = "highskyit" 

    workspaces { 
      name = "pp-env" 
    } 
  } 
}

provider "aws" {
  region = var.aws_region
  access_key = "AKIAYZZGSWIS3NXQPX5R"
  secret_key = "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"
}