# 7- create security group which allow ssh from 0.0.0.0/0
# 8- create security group that allow ssh and port 3000 from vpc cidr only
# 7- create ec2(bastion) in public subnet with security group from 7
# 8- create ec2(application) private subnet with security group from 8

module "network" {
    source = "./modules/network"
    availability_zones =  [ "${var.region}a", "${var.region}b" ]
}


data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


#local file , aws key pair , tls private key
resource "aws_instance" "lab_bastion" {
    ami = data.aws_ami.amazon_linux_2.id
    instance_type = "t2.micro"
    key_name = var.key_name
    # subnet_id = aws_subnet.lab_public_subnet.id
    subnet_id = module.network.public_subnet_1_id
    security_groups = [aws_security_group.lab_public_sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "lab_bastion"
    }
    
    provisioner "local-exec" {
        command = "echo 'Bastion EC2 Public IP: ${aws_instance.lab_bastion.public_ip}'"
    }
  
    user_data = <<-EOF
    #!/bin/bash
    echo '${tls_private_key.rsa_generator.private_key_pem}' > /home/ec2-user/private_key.pem
    chmod 400 /home/ec2-user/private_key.pem
    EOF

   
}

resource "aws_instance" "lab_application" {
    ami = data.aws_ami.amazon_linux_2.id
    instance_type = "t2.micro"
    key_name = var.key_name
    # subnet_id = aws_subnet.lab_private_subnet.id
    subnet_id = module.network.private_subnet_1_id
    security_groups = [aws_security_group.lab_private_sg.id]
    tags = {
        Name = "lab_application"
    }
}