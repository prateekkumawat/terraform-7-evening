module "vpc_infra"{
source = "../modules/vpc"
infraenv         = "stage"
clientname       = "hsit-use1"
vpc_cidr_network = "10.10.0.0/16"
subnet_az        = ["ap-south-1a", "ap-south-1b"]
subnet_cidr      = ["10.10.1.0/24", "10.10.2.0/24"]
} 

module "security_group_infra"{
source           = "../modules/securitygroup"
infraenv         = "stage"
clientname       = "hsit-use1"
vpc_id           = module.vpc_infra.vpc_id
}

module "infra_keys" {
source           = "../modules/keys" 
key_name         = "ins1" 
}

module "ec2_infra" {
source           = "../modules/ec2" 
key_name         = "ins1"
infraenv         = "stage"
clientname       = "hsit-use1"
ami_instance     = "ami-0861f4e788f5069dd"
instance_type    = "t2.micro"
public_subnet_id = module.vpc_infra.public_subnet_id
securitygroup_id = module.security_group_infra.securitygroup_id
}