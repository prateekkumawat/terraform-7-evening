output "vpc_id" {
    value = aws_vpc.this1.id
}

output "public_subnet_id" {
  value = aws_subnet.this1publicsubnet.id
}

output "private_subnet_id" {
  value = aws_subnet.this1privatesubnet.id
}