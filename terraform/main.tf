terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# terraform {
#   backend "s3" {
#     bucket         = "priya-resume-challenge-bucket-2"
#     key            = "remote/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "resume-statelock-table-2"

#   }
# }

