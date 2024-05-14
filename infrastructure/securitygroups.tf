resource "aws_security_group" "lab_public_sg" {
    vpc_id = module.network.vpc_id
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
    vpc_id = module.network.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        # cidr_blocks = [aws_vpc.lab_vpc.cidr_block]
        cidr_blocks = [module.network.vpc_cidr]
    }
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        # cidr_blocks = [aws_vpc.lab_vpc.cidr_block]
        cidr_blocks = [module.network.vpc_cidr]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

#Create a security group for RDS
resource "aws_security_group" "lab_rds_sg" {
    vpc_id = module.network.vpc_id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [module.network.vpc_cidr]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "lab-rds-sg"
    }
}

#Create a security group for elasticache
resource "aws_security_group" "elasticache_sg" {
    vpc_id = module.network.vpc_id
    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        cidr_blocks = [module.network.vpc_cidr]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "lab-elasticache-sg"
    }
}