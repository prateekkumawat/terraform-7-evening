aws_region = "ap-south-1"
subnet_details = {
  public-subnet1 = {
    Name       = "public-subnet1"
    prefix     = "highsky-use1"
    cidr_block = "10.10.1.0/24"
    avaibility_zone = "ap-south-1a"
    vpc_id = "vpc-0b78190a9d8f67d59"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet1-az1"
      enviornment = "pp"
      info = "pp"
      createbyterraform = "true"
    }  
  }
  public-subnet2 = {
    Name     = "public-subnet2"
    prefix     = "highsky-use1"
    cidr_block = "10.10.2.0/24"
    avaibility_zone = "ap-south-1b"
    vpc_id = "vpc-0b78190a9d8f67d59"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet2-az2"
      enviornment = "pp"
      info = "pp"
      createbyterraform = "true"
    }  
  }
  private-subnet1 = {
    Name       = "public-subnet1"
    prefix     = "highsky-use1"
    cidr_block = "10.10.3.0/24"
    avaibility_zone = "ap-south-1a"
    vpc_id = "vpc-0b78190a9d8f67d59"
    map_public_ip_on_launch = true
    tags = {
      Name = "private-subnet1-az1"
      enviornment = "pp"
      info = "pp"
      createbyterraform = "true"
    }  
  }
  private-subnet2 = {
    Name       = "private-subnet2"
    prefix     = "highsky-use1"
    cidr_block = "10.10.4.0/24"
    avaibility_zone = "ap-south-1b"
    vpc_id = "vpc-0b78190a9d8f67d59"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet1-az1"
      enviornment = "pp"
      info = "pp"
      createbyterraform = "true"
    }  
  }
} 
