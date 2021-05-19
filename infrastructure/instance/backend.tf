

terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    region  = "eu-west-2"
    profile = "default"
    key     = "terraformstatefile"
    bucket  = "terraform-artifacts-bucket-8699"
  }
}

