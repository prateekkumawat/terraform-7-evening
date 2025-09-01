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

# create a securitygroup for public instance 
resource "aws_security_group" "this1sgpub" {
  name = "${var.clientname}-${var.infraenv}-securitygroup-publicins"
  vpc_id = aws_vpc.this1.id
  description = "Allow SSH Rule for instnce"
  
  ingress {
    from_port = 22
    to_port =   22
    protocol =  "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  egress {
    from_port = 0
    to_port =   0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.clientname}-${var.infraenv}-securitygroup-publicins"
  }
}

# create a security group for private 
resource "aws_security_group" "this1sgprivate" {
  name = "${var.clientname}-${var.infraenv}-securitygroup-private"
  vpc_id = aws_vpc.this1.id
  description = "Allow SSH Rule for instnce"
  
  ingress {
    from_port = 22
    to_port =   22
    protocol =  "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  egress {
    from_port = 0
    to_port =   0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.clientname}-${var.infraenv}-securitygroup-private"
  }
}

# create a keypair for public instance 
resource "tls_private_key" "this1key1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "thiskeypair1" {
  key_name = "public_instance_key"
  public_key = tls_private_key.this1key1.public_key_openssh
}

resource "local_file" "key1ins1file" {
  filename =  "./key/public_instnace_key.pem"
  content = tls_private_key.this1key1.private_key_pem
}


resource "tls_private_key" "this1key2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "thiskeypair2" {
  key_name = "private_instance_key"
  public_key = tls_private_key.this1key2.public_key_openssh
}

resource "local_file" "key1ins2file" {
  filename =  "./key/private_instnace_key.pem"
  content = tls_private_key.this1key2.private_key_pem
}



# cratea apublic instnace in public subnet 
resource "aws_instance" "public1" {
  ami = var.ami_instance
  instance_type = var.instance_type
  subnet_id = aws_subnet.this1publicsubnet.id 
  vpc_security_group_ids = [aws_security_group.this1sgpub.id]
  key_name = aws_key_pair.thiskeypair1.key_name

  tags = {
     Name = "${var.clientname}-${var.infraenv}-publicinstance"
  }  
}

resource "aws_instance" "private1" {
  ami = var.ami_instance
  instance_type = var.instance_type
  subnet_id = aws_subnet.this1privatesubnet.id 
  vpc_security_group_ids = [aws_security_group.this1sgprivate.id]
  key_name = aws_key_pair.thiskeypair2.key_name

  tags = {
     Name = "${var.clientname}-${var.infraenv}-privateinstance"
  }  
}