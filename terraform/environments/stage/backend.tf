terraform {
  backend "s3" {
    bucket         = "REPLACE-dev-tf-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "REPLACE-dev-tf-locks"
  }
}
