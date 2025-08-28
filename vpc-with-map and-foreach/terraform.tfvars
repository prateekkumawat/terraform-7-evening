infraenv = "pp"
clientname = "abc-use1"
vpc_cidr_network = "10.20.0.0/16"
aws_region = "ap-south-1"
public_subnet_details = {
  "public1" = {
    vpc_id = "vpc-066cafea57c29b000"
    cidr_block = "10.20.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true 
  }
  "public2" = {
    vpc_id = "vpc-066cafea57c29b000"
    cidr_block = "10.20.3.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true 
  }
}
private_subnet_details = {
  "private1" = {
    vpc_id = "vpc-066cafea57c29b000"
    cidr_block = "10.20.2.0/24"
    availability_zone = "ap-south-1a"
  }
  "private2" = {
    vpc_id = "vpc-066cafea57c29b000"
    cidr_block = "10.20.4.0/24"
    availability_zone = "ap-south-1b"
  }
}