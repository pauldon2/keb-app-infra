##
terraform {
  required_version = ">= 1.6.0, < 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0, < 6.0.0"
    }
  }

}

provider "aws" {
  region = var.aws_region
}


/*
terraform {
  backend "s3" {
    bucket         = "terraform-keb-euc1"
    key            = "terraform/devops-keb-ec2.tfstate"
    region         = "eu-central-1"  ## Variables not allowed
    dynamodb_table = "terraform-keb-euc1-ec2"
  }
}
*/
