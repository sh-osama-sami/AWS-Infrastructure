# Networking
# 1- create vpc
# 2- create internet gateway
# 3- create public route table
# 4- create private route table
# 5- create public route
# 6- attach public route table to subnets

resource "aws_vpc" "lab_vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "lab_vpc"
    }
}

data "aws_availability_zones" "available" {
  state = "available"
#   region = "us-east-1"
}

resource "aws_subnet" "lab_public_subnet"{
    vpc_id = aws_vpc.lab_vpc.id
    cidr_block = "10.0.0.0/24"  
    availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "lab_private_subnet"{
    vpc_id = aws_vpc.lab_vpc.id
    cidr_block = "10.0.1.0/24"
     availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_internet_gateway" "lab_igw"{
    vpc_id = aws_vpc.lab_vpc.id

}

resource "aws_route_table" "lab_public_route_table"{
    vpc_id = aws_vpc.lab_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.lab_igw.id
    }
    tags = {
        Name = "lab_public_route_table"
    }
}

resource "aws_route_table_association" "lab_public_route_table_association"{
    subnet_id = aws_subnet.lab_public_subnet.id
    route_table_id = aws_route_table.lab_public_route_table.id
}

resource "aws_route_table" "lab_private_route_table"{
    vpc_id = aws_vpc.lab_vpc.id
    tags = {
        Name = "lab_private_route_table"
    }
}

resource "aws_route_table_association" "lab_private_route_table_association"{
    subnet_id = aws_subnet.lab_private_subnet.id
    route_table_id = aws_route_table.lab_private_route_table.id
}





# 1-create two workspaces dev and prod
# 2-create two variable definition files(.tfvars) for the two environments
# 3-separate network resources into network module
# 4-apply your code to create two environments one in us-east-1 and eu-central-1
# 5-run local-exec provisioner to print the public_ip of bastion ec2
# 6- upload infrastructure code on github project

# 1- create rds in private subnet
# 2- create elastic cache in private subnet

# 9-verify your email in ses service
# 10- create lambda function to send email
# 11-create trigger to detect changes in state file and send the email