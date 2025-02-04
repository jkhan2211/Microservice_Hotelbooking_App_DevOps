terraform {
  backend "s3" {
    bucket         = "hotelapp-infra-state-bucket"
    region         = "us-east-1"
    dynamodb_table = "hotelapp-infra-state-lock"
    key            = "global/hotelinfrastatefile/terraform.tfstate"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"   # Change to your desired region
  profile = "junaid-test" # Replace with your actual AWS SSO profile
}
