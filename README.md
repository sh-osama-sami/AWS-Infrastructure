# Secure Networking and Compute Infrastructure Setup

## Overview
This project aims to establish a secure networking and compute infrastructure within a cloud environment. It involves setting up Virtual Private Cloud (VPC), internet gateway, route tables, security groups, and EC2 instances with specific configurations to ensure robustness and security.

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
2. **Create two variable definition files (.tfvars) for the two environments.**
3. **Separate network resources into network module.**
4. **Apply your code to create two environments:** one in `us-east-1` and `eu-central-1`.
5. **Run local-exec provisioner to print the public IP of bastion EC2.**
6. **Upload infrastructure code on GitHub project.**

### Additional Steps:

1. **Create RDS in private subnet.**
2. **Create Elastic Cache in private subnet.**

## AWS Services Integration

1. **Verify your email in SES service.**
2. **Create Lambda function to send email.**
3. **Create trigger to detect changes in state file and send the email.**
