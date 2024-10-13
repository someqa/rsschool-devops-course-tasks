# RSSchool DevOps Course Tasks

This repository contains Terraform configurations for deploying infrastructure in AWS.

## Features
VPC Configuration

1. VPC with CIDR block defined in variables.
- 2 Public Subnets in different AZs.
- 2 Private Subnets in different AZs.
- Internet Gateway for public subnets.
- Routing Configuration

Instances in all subnets can communicate with each other.
Public instances can reach external addresses.

2. Security
Security Groups configured for instances.

3. Bastion Host
A bastion host created in a public subnet for secure SSH access to private instances.

4.NAT Instance
A NAT instance in a public subnet to allow private instances to access the internet.

# Infrastructure Setup and Usage

## File Structure

The project is organized into a main directory containing a terraform folder. Inside this folder:
- bastion-instance.tf: This file configures bastion for private instances.
- ec-instances-test.tf: This file configures 4 instances for test, one for each sub-network.
- main.tf: This is the primary configuration file where the main infrastructure components are defined.
- outpuf.tf: File with the data to output.
- provider.tf: This file specifies the AWS provider configuration, including credentials and region settings.
- resources-nat-instance.tf: This file specifies NAT EC2 instance config.
- resources-network.tf: This file specifies VPC and private/public networks.
- resources-roles.tf: This file contains the definitions for IAM roles and policies required for the infrastructure.
- resources-routes.tf: This file specifies route tables.
- resources-s3.tf: This file is dedicated to configuring S3 buckets and related settings.
- resources-sg.tf: This file specifies security groups for the instances.
- variables.tf: This file defines the variables used throughout the Terraform configuration, ensuring flexibility and reusability.

Additionally, there may be `terraform.tfvars` file for storing specific values for the variables defined in variables.tf, allowing easy customization of the infrastructure setup (not commited).

## GitHub Actions Workflow and env vars

The workflow for deployment is defined in `.github/workflows/terraform_deployment.yml`. Key environment variables to set in `terraform.tfvars`:

```
aws_account_id = "your_aws_account_id"
repository = "your_github_repository"
thumbnail = "your_thumbprint"
```

# Usage
Clone the Repository:

`git clone https://github.com/someqa/rsschool-devops-course-tasks.git`

Install terraform.
Set env vars.
Generate SSH key to be used for access to the test instances:
```
ssh-keygen -t rsa -b 2048 -f ~/.ssh/someqa-key -q -N "" 
```
Use
`terraform apply`
to deploy changes or 
the GitHub Actions workflow will handle the deployment when you push changes to the main branch.

# Cleanup
To remove resources, run:
`terraform destroy`
