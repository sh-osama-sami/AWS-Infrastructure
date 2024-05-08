
resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = var.public_subnet_1_cidr
    availability_zone       = var.availability_zones[0]
    map_public_ip_on_launch = true
   
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = var.public_subnet_2_cidr
    availability_zone       = var.availability_zones[1]
    map_public_ip_on_launch = true
   
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = var.private_subnet_1_cidr
    availability_zone       = var.availability_zones[0]
    
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = var.private_subnet_2_cidr
    availability_zone       = var.availability_zones[1]
   
}

