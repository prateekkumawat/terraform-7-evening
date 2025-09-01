resource "aws_vpc" "this1" {
  cidr_block = var.vpc_cidr_network
  tags = {
    Name = "${var.clientname}-${var.infraenv}-vpc"
  }
}

resource "aws_subnet" "this1publicsubnet" {
 vpc_id = aws_vpc.this1.id 
 cidr_block = var.subnet_cidr[0]
 availability_zone = var.subnet_az[0]
 map_public_ip_on_launch = true
  tags = {
    Name = "${var.clientname}-${var.infraenv}-pub-subnet1"
  }
}

resource "aws_subnet" "this1privatesubnet" {
 vpc_id = aws_vpc.this1.id 
 cidr_block = var.subnet_cidr[1]
 availability_zone = var.subnet_az[1]
 map_public_ip_on_launch = false
  tags = {
    Name = "${var.clientname}-${var.infraenv}-priv-subnet1"
  }
}

resource "aws_internet_gateway" "this1igw" {
  vpc_id = aws_vpc.this1.id 
 tags = {
    Name = "${var.clientname}-${var.infraenv}-igw"
  }
}

resource "aws_eip" "this1nateip" {
  domain = "vpc"
  tags = {
    Name = "${var.clientname}-${var.infraenv}-nat-eip"
  }
}

resource "aws_nat_gateway" "this1nat" {
  allocation_id = aws_eip.this1nateip.id
  subnet_id = aws_subnet.this1publicsubnet.id
  tags = {
    Name = "${var.clientname}-${var.infraenv}-nat"
  }
}

resource "aws_route_table" "this1pubrt" {
  vpc_id = aws_vpc.this1.id
  route { 
    gateway_id = aws_internet_gateway.this1igw.id 
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "${var.clientname}-${var.infraenv}-publicrt"
  }
}

resource "aws_route_table" "this1privrt" {
  vpc_id = aws_vpc.this1.id
  route { 
    nat_gateway_id = aws_nat_gateway.this1nat.id  
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "${var.clientname}-${var.infraenv}-privatert"
  }
}

resource "aws_route_table_association" "assosiationpublic1" {
  subnet_id = aws_subnet.this1publicsubnet.id 
  route_table_id = aws_route_table.this1pubrt.id 
}

resource "aws_route_table_association" "assosiationprivate1" {
  subnet_id = aws_subnet.this1privatesubnet.id 
  route_table_id = aws_route_table.this1privrt.id
}