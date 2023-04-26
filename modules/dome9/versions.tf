terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    dome9 = {
      source  = "dome9/dome9"
      version = "1.29.0"
    }
  }
}
