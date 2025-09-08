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

resource "aws_subnet" "this1privatesubnet2" {
 vpc_id = aws_vpc.this1.id 
 cidr_block = var.subnet_cidr[2]
 availability_zone = var.subnet_az[0]
 map_public_ip_on_launch = false
  tags = {
    Name = "${var.clientname}-${var.infraenv}-priv-subnet2"
  }
}

resource "aws_internet_gateway" "this1igw" {
  vpc_id = aws_vpc.this1.id 
 tags = {
    Name = "${var.clientname}-${var.infraenv}-igw"
  }
}

# resource "aws_eip" "this1nateip" {
#   domain = "vpc"
#   tags = {
#     Name = "${var.clientname}-${var.infraenv}-nat-eip"
#   }
# }

# resource "aws_nat_gateway" "this1nat" {
#   allocation_id = aws_eip.this1nateip.id
#   subnet_id = aws_subnet.this1publicsubnet.id
#   tags = {
#     Name = "${var.clientname}-${var.infraenv}-nat"
#   }
# }

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
  # route { 
  #   nat_gateway_id = aws_nat_gateway.this1nat.id  
  #   cidr_block = "0.0.0.0/0"
  # }
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

resource "aws_route_table_association" "assosiationprivate2" {
  subnet_id = aws_subnet.this1privatesubnet2.id
  route_table_id = aws_route_table.this1privrt.id
}


resource "aws_security_group" "this1rdssg" {
  vpc_id = aws_vpc.this1.id 
  description = "Allow RDS Services in security group"
  name = "${var.clientname}-${var.infraenv}-rds"
  ingress {
    to_port = "3306"
    from_port = "3306"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { 
    to_port = "0"
    from_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.clientname}-${var.infraenv}-rds"
  }
}


resource "aws_db_subnet_group" "this1dbgrp" {
   subnet_ids = [aws_subnet.this1privatesubnet.id, aws_subnet.this1privatesubnet2.id]
   tags = {
    Name = "${var.clientname}-${var.infraenv}-rds-sybnet-group"
   }
}

resource "aws_db_instance" "this1db1" {
  allocated_storage = 10
  identifier = "${var.clientname}-${var.infraenv}-rds"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username = "admin"
  password = "Redhat123456"
  skip_final_snapshot = false
  db_subnet_group_name = aws_db_subnet_group.this1dbgrp.id
  vpc_security_group_ids = [aws_security_group.this1rdssg.id]
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