terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-someqa"  
    key            = "dev/terraform.tfstate"
    region         = "eu-north-1"                        
    encrypt        = true
  }
}
