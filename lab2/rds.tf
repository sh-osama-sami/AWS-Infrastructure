

#Create a DB subnet group
resource "aws_db_subnet_group" "lab_db_subnet_group" {
    name       = "lab-db-subnet-group"
    subnet_ids = [module.network.private_subnet_1_id, module.network.private_subnet_2_id]
    tags = {
        Name = "lab-db-subnet-group"
    }
}



#create an RDS instance
resource "aws_db_instance" "lab_rds" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t3.micro"  # Adjust the instance class
    db_name              = "lab_db"             
    username             = "admin"
    password             = "admin123"
    parameter_group_name = "default.mysql5.7"
    vpc_security_group_ids = [aws_security_group.lab_rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.lab_db_subnet_group.name
    publicly_accessible = false
    skip_final_snapshot = true
    tags = {
        Name = "lab-rds"
    }
}
