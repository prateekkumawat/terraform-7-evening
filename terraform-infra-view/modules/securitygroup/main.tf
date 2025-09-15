resource "aws_security_group" "this1sgprivate" {
  name = "${var.clientname}-${var.infraenv}-securitygroup-private"
  vpc_id = var.vpc_id
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