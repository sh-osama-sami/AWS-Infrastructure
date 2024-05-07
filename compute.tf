# 7- create security group which allow ssh from 0.0.0.0/0
# 8- create security group that allow ssh and port 3000 from vpc cidr only
# 7- create ec2(bastion) in public subnet with security group from 7
# 8- create ec2(application) private subnet with security group from 8

resource "aws_security_group" "lab_public_sg" {
    vpc_id = aws_vpc.lab_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "lab_public_sg"
    }
}

resource "aws_security_group" "lab_private_sg" {
    vpc_id = aws_vpc.lab_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.lab_vpc.cidr_block]
    }
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = [aws_vpc.lab_vpc.cidr_block]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
#local file , aws key pair , tls private key
resource "aws_instance" "lab_bastion" {
    ami = "ami-04e5276ebb8451442"
    instance_type = "t2.micro"
    key_name = "sherry-key"
    subnet_id = aws_subnet.lab_public_subnet.id
    security_groups = [aws_security_group.lab_public_sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "lab_bastion"
    }
}

resource "aws_instance" "lab_application" {
    ami = "ami-04e5276ebb8451442"
    instance_type = "t2.micro"
    key_name = "sherry-key"
    subnet_id = aws_subnet.lab_private_subnet.id
    security_groups = [aws_security_group.lab_private_sg.id]
    tags = {
        Name = "lab_application"
    }
}

# user data for private key 
# provisioners 