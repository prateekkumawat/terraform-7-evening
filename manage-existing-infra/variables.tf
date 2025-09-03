variable "infraenv" {
    description = "please give client name eg client-use1 "
}
variable "aws_region" {
    description = "please give aws region"
}
variable "clientname" {
    description = "please provide infra name eg stage pp prod"
}
variable "subnet_az" {
  type = list 
}
variable "subnet_cidr" {
  type = list 
}
variable "vpc_id" {}
variable "subnet1_id" {}
variable "subnet2_id" {}
variable "internet_gateway_id" {}
variable "public_route_table_id" {}
variable "private_route_table_id" {}