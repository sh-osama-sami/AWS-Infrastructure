terraform {
  backend "s3" {
    bucket         = "sherrys-terraform" #should exist before running terraform init
    key            = "terraform.tfstate" #shouldn't exist before running terraform init
    region         = "us-east-1"
    dynamodb_table = "terraform-lock" #should exist before running terraform init

  }
}
 
