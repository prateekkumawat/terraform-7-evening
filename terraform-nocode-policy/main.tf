module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name              = "hsit-pp-nocode"
  cidr              = "10.0.0.0/16"
  
  azs               = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  database_subnets   = ["10.0.19.0/24", "10.0.20.0/24", "10.0.21.0/24"] 
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true
}

module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "test-aurora-db-postgres96"
  engine         = "aurora-postgresql"
  engine_version = "14.5"
  instance_class = "db.t2.medium"
  vpc_id         = "vpc-04dce7f124cbb9a04"
  create_db_subnet_group = true
  db_subnet_group_name = "db-subnet-grp"
  subnets = ["subnet-0dec2ccd3a373d0c2", "subnet-0f52f3f603c2308ef", "subnet-0aec4172797ab04fd"]
  security_group_rules = {
    ex1_ingress = {
      cidr_blocks = ["10.20.0.0/20"]
    }
  }  
  storage_encrypted   = true
  apply_immediately   = true  
}  