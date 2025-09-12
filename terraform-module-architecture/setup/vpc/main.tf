module "vpc" {
  source = "../../module/vpc"
  vpc_details = var.vpc_details
}