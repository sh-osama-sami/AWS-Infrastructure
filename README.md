# Secure Networking and Compute Infrastructure Setup

## Overview
This project aims to establish a secure networking and compute infrastructure within a cloud environment. It involves setting up Virtual Private Cloud (VPC), internet gateway, route tables, security groups, and EC2 instances with specific configurations to ensure robustness and security.

## Project Components
### Networking
1. **Create VPC**: Establishes a dedicated Virtual Private Cloud to isolate resources securely.
2. **Create Internet Gateway**: Enables communication between the VPC and the internet for necessary external access.
3. **Create Public Route Table**: Defines a route table to direct traffic from the public subnet to the internet gateway.
4. **Create Private Route Table**: Configures a route table to manage internal traffic within the private subnet.
5. **Create Public Route**: Sets up a route to direct traffic from the public subnet to the internet gateway for external access.
6. **Attach Public Route Table to Subnets**: Associates the public route table with designated subnets to control outbound traffic.

### Compute
7. **Create Security Group for SSH Access (0.0.0.0/0)**: Establishes a security group to allow SSH access from any source IP address for administration purposes.
8. **Create Security Group for SSH and Port 3000 Access (VPC CIDR)**: Configures a security group to permit SSH and port 3000 access specifically from within the VPC CIDR range, limiting access to internal traffic.
9. **Create EC2 Instance (Bastion) in Public Subnet**: Deploys an EC2 instance (bastion host) within the public subnet with the security group defined in step 7, providing a secure gateway for accessing internal resources.
10. **Create EC2 Instance (Application) in Private Subnet**: Launches an EC2 instance within the private subnet with the security group configured in step 8, ensuring restricted access to SSH and port 3000 from within the VPC CIDR.

## Project Deliverables
- Fully functional VPC with appropriate networking components.
- Securely configured EC2 instances in both public and private subnets.
- Detailed documentation outlining the setup procedures and configurations for future reference and maintenance.

## Usage
1. Ensure you have necessary permissions to create VPC, internet gateway, route tables, security groups, and EC2 instances in your cloud environment.
2. Follow the steps outlined in the documentation to set up the infrastructure.
3. Test the setup thoroughly to ensure all components are functioning as expected.

