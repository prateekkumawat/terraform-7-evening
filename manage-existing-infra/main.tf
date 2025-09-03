data "aws_vpc" "this1" {
   id = var.vpc_id
}

data "aws_subnet" "this1subnet1" {
  id = var.subnet1_id
}

data "aws_subnet" "this1subnet2" {
  id = var.subnet2_id
}

data "aws_internet_gateway" "this1igw" {
  internet_gateway_id =  var.internet_gateway_id
}

data "aws_route_table" "this1public" {
  route_table_id   = var.public_route_table_id
}
data "aws_route_table" "this1private" {
  route_table_id   = var.private_route_table_id
}

resource "aws_subnet" "this1subnet3" {
  cidr_block = var.subnet_cidr[0]
  availability_zone = var.subnet_az[0]
  vpc_id = data.aws_vpc.this1.id
  map_public_ip_on_launch = true 
  tags = { 
    Name = "${var.clientname}-${var.infraenv}-subnet3-${var.subnet_az[0]}"
  }
}

resource "aws_subnet" "this1subnet4" {
  cidr_block = var.subnet_cidr[1]
  availability_zone = var.subnet_az[1]
  vpc_id = data.aws_vpc.this1.id
  map_public_ip_on_launch = false
  tags = { 
    Name = "${var.clientname}-${var.infraenv}-subnet4-${var.subnet_az[1]}"
  }
}

resource "aws_route_table_association" "assosiate1" {
  subnet_id = aws_subnet.this1subnet3.id
  route_table_id = data.aws_route_table.this1public.id
}

resource "aws_route_table_association" "assosiate2" {
  subnet_id = aws_subnet.this1subnet4.id
  route_table_id = data.aws_route_table.this1private.id
}