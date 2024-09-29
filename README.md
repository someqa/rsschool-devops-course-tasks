# RSSchool DevOps Course Tasks

This repository contains Terraform configurations for deploying infrastructure in AWS.

# Infrastructure Setup and Usage

## File Structure

The project is organized into a main directory containing a terraform folder. Inside this folder:

- main.tf: This is the primary configuration file where the main infrastructure components are defined.
- provider.tf: This file specifies the AWS provider configuration, including credentials and region settings.
- resources-roles.tf: This file contains the definitions for IAM roles and policies required for the infrastructure.
- resources-s3.tf: This file is dedicated to configuring S3 buckets and related settings.
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
Use
`terraform apply`
to deploy changes or 
the GitHub Actions workflow will handle the deployment when you push changes to the main branch.

# Cleanup
To remove resources, run:
`terraform destroy`
