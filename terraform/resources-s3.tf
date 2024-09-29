resource "aws_s3_bucket" "tf-example" {
  bucket = var.tf_created_s3_bucket
}
