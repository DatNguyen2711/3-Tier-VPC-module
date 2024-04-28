terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  cloud {
    organization = "Datlaid-FPT"

    workspaces {
      name = "My-WS"
    }
  }
}
provider "aws" {
  region  = "ap-southeast-1"
}
