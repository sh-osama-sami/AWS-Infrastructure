provider "aws" {
  region = "us-east-1"
  
}


resource "aws_iam_user" "lab_user" {
  name = "lab_user"
}

resource "aws_iam_access_key" "lab_user_access_key" {
  user = aws_iam_user.lab_user.name
}

resource "aws_secretsmanager_secret" "iam_access_key_secret" {
  name = "iam-access-key-secret"
}

resource "aws_secretsmanager_secret_version" "iam_access_key_secret_version" {
  secret_id     = aws_secretsmanager_secret.iam_access_key_secret.id
  secret_string = aws_iam_access_key.lab_user_access_key.secret
}
