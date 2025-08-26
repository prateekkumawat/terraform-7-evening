resource "aws_vpc" "this1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "this1subnet1" {
  vpc_id = aws_vpc.this1.id
  availability_zone = "ap-south-1a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terraform-vpc-subnet1-az1"
  }
}

resource "aws_subnet" "this1subnet2" {
  vpc_id = aws_vpc.this1.id
  availability_zone = "ap-south-1b"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "terraform-vpc-subnet2-az2"
  }
}

resource "aws_internet_gateway" "this1igw" {
  vpc_id = aws_vpc.this1.id
  tags = {
    Name = "terraform-vpc-igw"
  }
}

resource "aws_route_table" "this1pubrt" {
  vpc_id = aws_vpc.this1.id
  route {
    gateway_id = aws_internet_gateway.this1igw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "this1pub1" {
  subnet_id = aws_subnet.this1subnet1.id
  route_table_id = aws_route_table.this1pubrt.id
}


resource "aws_security_group" "this1sg" {
  vpc_id = aws_vpc.this1.id
  name = "aws security group terraform "
  description = "terraform created"

  ingress {
    to_port = "22"
    from_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    to_port = "0"
    from_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this1ins1" {
   ami = "ami-02d26659fd82cf299"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.this1subnet1.id
   security_groups = [aws_security_group.this1sg.id]
   key_name = "mount.pem"
   tags = {
    Name = "terraform-instance-1"
   }
}