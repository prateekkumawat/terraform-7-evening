# create a keypair for public instance 
resource "tls_private_key" "this1key1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "thiskeypair1" {
  key_name = var.key_name
  public_key = tls_private_key.this1key1.public_key_openssh
}

resource "local_file" "key1ins1file" {
  filename =  "../setup-infra/keys/${var.key_name}.pem"
  content = tls_private_key.this1key1.private_key_pem
}
