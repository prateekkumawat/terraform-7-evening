output "rds_endpoint" {
    value = aws_db_instance.this1db1.endpoint
}
output "rds_username" {
  value = aws_db_instance.this1db1.username
}

output "rds_port_number" {
    value = aws_db_instance.this1db1.port
}

output "aws_instance_public_ip" {
  value = aws_instance.public1.public_ip
}