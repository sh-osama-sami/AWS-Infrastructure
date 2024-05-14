resource "tls_private_key" "rsa_generator" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "public_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_generator.public_key_openssh

}

resource "local_file" "private_key_file" {
  filename = "private_key.pem"
  content  = tls_private_key.rsa_generator.private_key_pem
}

   


