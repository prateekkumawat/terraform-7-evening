resource "aws_vpc" "this1" {
  cidr_block = var.vpc_cidr_network
  tags = {
    Name = "${var.clientname}-${var.infraenv}-vpc"
  }
}

resource "aws_subnet" "this1subnet1" {
  vpc_id = aws_vpc.this1.id
  cidr_block = var.subnet_cidr[0] 
  availability_zone = var.az[0] 
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.clientname}-${var.infraenv}-public-subnet"
  }
}

resource "aws_subnet" "this1subnet2" {
  vpc_id = aws_vpc.this1.id
  cidr_block = var.subnet_cidr[1] 
  availability_zone = var.az[1] 
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.clientname}-${var.infraenv}-private-subnet"
  }
}

resource "aws_internet_gateway" "this1igw" {
  vpc_id = aws_vpc.this1.id
  tags = {
    Name =  "${var.clientname}-${var.infraenv}-igw"
  }
}
