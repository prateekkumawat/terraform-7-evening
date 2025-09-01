variable "aws_region" {}
variable "clientname" {}
variable "infraenv" {}
variable "vpc_cidr_network" {}
variable "subnet_cidr" {
    type = list   
}
variable "subnet_az" {
  type = list 
}
variable "ami_instance" {}
variable "instance_type" {}