variable "infraenv" {
    description = "please give client name eg client-use1 "
}
variable "aws_region" {
    description = "please give aws region"
}
variable "clientname" {
    description = "please provide infra name eg stage pp prod"
}
variable "vpc_cidr_network" {
    description = "please provide your vpc cidr network"
}

variable "public_subnet_details" {
   type = map(object({ 
    cidr_block  = string
    availability_zone = string
    vpc_id = string
    map_public_ip_on_launch = bool
   }))
}

variable "private_subnet_details" {
   type = map(object({ 
    cidr_block  = string
    availability_zone = string
    vpc_id = string
   }))
}