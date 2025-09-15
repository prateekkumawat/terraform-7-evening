resource "aws_instance" "public1" {
  ami = var.ami_instance
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [var.securitygroup_id]
  key_name = var.key_name

  tags = {
     Name = "${var.clientname}-${var.infraenv}-publicinstance"
  }  
}