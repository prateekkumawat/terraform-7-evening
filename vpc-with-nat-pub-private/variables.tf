variable "aws_region" {}
#variable "access_key" {}
#variable "secret_key" {}
variable "clientname" {}
variable "infraenv" {}
variable "vpc_cidr_network" {}
variable "subnet_cidr" {
    type = list   
}
variable "subnet_az" {
  type = list 
}
