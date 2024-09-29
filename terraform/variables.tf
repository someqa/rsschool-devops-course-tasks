variable "tf_created_s3_bucket" {
  description = "Name of the S3 bucket for storing the Terraform state"
  type        = string
  default     = "tf-created-bucket-someqa" 
}

variable "aws_region" {
  description = "The AWS region where the S3 bucket is located"
  type        = string
  default     = "eu-north-1"
}

variable "repository" {
  description = "GitHub username"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "thumbnail" {
  description = "AWS thumbnail"
  type        = string
}

variable "gh_iam_policies" {
  description = "The List of Required IAM Policies"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
  ]
}
