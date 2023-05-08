provider "aws" {
  region = var.REGION
}

terraform {
  backend "s3" {
    bucket = "tf-backend-confinguration"
    key    = "tf-backend"
    region = "us-east-1"

  }
}
