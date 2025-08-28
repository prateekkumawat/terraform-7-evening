resource "aws_vpc" "this1" {
  cidr_block = var.vpc_cidr_network
  tags = {
    Name = "${var.clientname}-${var.infraenv}-vpc"
  }
}

resource "aws_subnet" "this1publicsubnet" {
  for_each = var.public_subnet_details
  vpc_id = each.value.vpc_id
  cidr_block = each.value.cidr_block 
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags = {
    Name = "${var.clientname}-${var.infraenv}-public-subnet-${each.value.availability_zone}"
  }
}

resource "aws_subnet" "this1privatesubnet" {
  for_each = var.private_subnet_details
  vpc_id = each.value.vpc_id
  cidr_block = each.value.cidr_block 
  availability_zone = each.value.availability_zone
  tags = {
    Name = "${var.clientname}-${var.infraenv}-private-subnet-${each.value.availability_zone}"
  }
}

resource "aws_internet_gateway" "this1igw" {
  vpc_id = aws_vpc.this1.id
  tags = {
    Name =  "${var.clientname}-${var.infraenv}-igw"
  }
}
