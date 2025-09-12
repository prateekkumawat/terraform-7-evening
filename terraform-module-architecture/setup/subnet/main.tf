module "subnet" {
  source = "../../module/subnets"
  subnet_details = var.subnet_details
}