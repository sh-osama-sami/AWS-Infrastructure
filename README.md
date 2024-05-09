# Secure Networking and Compute Infrastructure Setup

## Overview
This project aims to establish a secure networking and compute infrastructure within a cloud environment. It involves setting up Virtual Private Cloud (VPC), internet gateway, route tables, security groups, RDS, Elasticache, a private EC2 instance and a bastion sever with specific configurations to ensure robustness and security.

## Project Components
## Networking

### Steps:

1. **Create VPC:** Establishes a dedicated Virtual Private Cloud to isolate resources securely.
2. **Create Internet Gateway:** Enables communication between the VPC and the internet for necessary external access.
3. **Create Public Route Table:** Defines a route table to direct traffic from the public subnet to the internet gateway.
4. **Create Private Route Table:** Configures a route table to manage internal traffic within the private subnet.
5. **Create Public Route:** Sets up a route to direct traffic from the public subnet to the internet gateway for external access.
6. **Attach Public Route Table to Subnets:** Associates the public route table with designated subnets to control outbound traffic.

## Compute

### Steps:

1. **Create Security Group for SSH Access (0.0.0.0/0):** Establishes a security group to allow SSH access from any source IP address for administration purposes.
2. **Create Security Group for SSH and Port 3000 Access (VPC CIDR):** Configures a security group to permit SSH and port 3000 access specifically from within the VPC CIDR range, limiting access to internal traffic.
3. **Create EC2 Instance (Bastion) in Public Subnet:** Deploys an EC2 instance (bastion host) within the public subnet with the security group defined in step 1, providing a secure gateway for accessing internal resources.
4. **Create EC2 Instance (Application) in Private Subnet:** Launches an EC2 instance within the private subnet with the security group configured in step 2, ensuring restricted access to SSH and port 3000 from within the VPC CIDR.

## Terraform Steps

### Network Module:

1. **Create two workspaces:** `dev` and `prod`.
   - ```bash
     terraform workspace new dev
     ```
   - ```
     terraform workspace new prod
     ```
3. **Create two variable definition files (.tfvars) for the two environments.**
   - [prod.tfvar](prod.tfvar) [dev.tfvar](dev.tfvar)
5. **Separate network resources into network module.**
   - [network](modules/network)
7. **Apply your code to create two environments:** one in `us-east-1` and `eu-central-1`.
   - define them in variables file 
9. **Run local-exec provisioner to print the public IP of bastion EC2.**
   - inside the bastion ec2 instance
   - ```hcl
      provisioner "local-exec" {
        command = "echo 'Bastion EC2 Public IP: ${aws_instance.lab_bastion.public_ip}'"
      }
     ```

### Additional Steps:

1. **Create RDS in private subnet.**
   - [RDS](rds.tf)
3. **Create Elastic Cache in private subnet.**
   - [Elasticache](elasticache)
     
## AWS Services Integration

1. **Verify your email in SES service.**
3. **Create Lambda function to send email.**
   - ```python
         import boto3
         from datetime import datetime, timedelta, timezone
         
         def lambda_handler(event, context):
             # Define the S3 bucket name storing Terraform state
             bucket_name = 'sherrys-terraform-bucket'
         
             # Create S3 client
             s3 = boto3.client('s3')
         
             # Get the list of objects in the bucket
             response = s3.list_objects_v2(Bucket=bucket_name)
         
             # Check if there are objects in the bucket
             if 'Contents' in response:
                 # Get the last modified timestamp of the most recent object
                 last_modified = max(obj['LastModified'] for obj in response['Contents'])
         
                 # Define the threshold time (e.g., 1 hour ago) as an offset-aware datetime object
                 threshold_time = datetime.now(timezone.utc) - timedelta(hours=1)
         
                 # If the last modified time is newer than the threshold time, send email
                 if last_modified > threshold_time:
                     send_email_notification()
             else:
                 print("No objects found in the bucket.")
         
         def send_email_notification():
             # Create SES client
             ses = boto3.client('ses')
         
             # Define email parameters
             sender = 'sh.osama.sami@gmail.com'
             recipient = 'mo883322@gmail.com'
             subject = 'S3 Bucket Updated'
             body_text = 'The Terraform state S3 bucket has been updated.'
         
             # Send email
             response = ses.send_email(
                 Source=sender,
                 Destination={
                     'ToAddresses': [recipient]
                 },
                 Message={
                     'Subject': {'Data': subject},
                     'Body': {'Text': {'Data': body_text}}
                 }
             )
         
             print("Email notification sent:", response)

     ```
     - Verify the sender's and reciver's email in ses
     - Add an IAM policy to the lambda function for the SES and the S3
       ```json
         {
             "Version": "2012-10-17",
             "Statement": [
                 {
                     "Effect": "Allow",
                     "Action": "ses:SendEmail",
                     "Resource": "*"
                 },
                 {
                     "Effect": "Allow",
                     "Action": "ses:SendRawEmail",
                     "Resource": "*"
                 }
             ]
         }

       ```
       ```json

         {
             "Version": "2012-10-17",
             "Statement": [
                 {
                     "Effect": "Allow",
                     "Action": [
                         "s3:ListBucket"
                     ],
                     "Resource": "arn:aws:s3:::your_bucket_name"
                 },
                 {
                     "Effect": "Allow",
                     "Action": [
                         "s3:GetObject"
                     ],
                     "Resource": "arn:aws:s3:::your_bucket_name/*"
                 }
             ]
         }

       ```
5. **Create an S3 trigger to detect changes in state file inside the bucket and send the email.**

   
## Project Deliverables
- Fully functional VPC with appropriate networking components.
- Securely configured EC2 instances in both public and private subnets.
- Detailed documentation outlining the setup procedures and configurations for future reference and maintenance.

## Usage
1. Ensure you have necessary permissions to create VPC, internet gateway, route tables, security groups, and EC2 instances in your cloud environment.
2. Follow the steps outlined in the documentation to set up the infrastructure.
3. Test the setup thoroughly to ensure all components are functioning as expected.

