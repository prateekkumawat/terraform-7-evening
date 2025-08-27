resource "aws_vpc" "this1" {
  cidr_block = var.vpc_cidr_network
  tags = {
    Name = "${var.clientname}-${var.infraenv}-vpc"
  }
}
