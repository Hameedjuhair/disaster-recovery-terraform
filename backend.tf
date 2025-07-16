terraform {
  backend "s3" {
    bucket         = "drac-terraform-states"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "drac-lock-table"
    encrypt        = true
  }
}
