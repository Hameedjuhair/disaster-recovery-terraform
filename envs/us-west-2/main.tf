provider "aws" {
  region = "us-west-2"
}

locals {
  environment = "dr"
}

# VPC Module
module "vpc" {
  source      = "../../modules/vpc"
  aws_region  = var.aws_region
  environment = local.environment
  project     = var.project_name
}

# Security Group Module
module "security_group" {
  source      = "../../modules/security_group"
  project     = var.project_name
  environment = local.environment
  vpc_id      = module.vpc.vpc_id
}

# RDS Restore Module (from snapshot)
# You can comment this out when not needed
module "rds_restore" {
  source              = "../../modules/rds"
  project             = var.project_name
  environment         = local.environment
  subnet_ids          = module.vpc.public_subnet_ids
  sg_id               = module.security_group.sg_id
  db_username         = var.db_username
  db_password         = var.db_password
  snapshot_identifier = "drac-prod-dr-snapshot"  # Replace with actual snapshot name
}

# Normal RDS Module (if restoring fresh DB, not from snapshot)
# Comment this out if `rds_restore` is active
# module "rds" {
#   source        = "../../modules/rds"
#   project       = var.project_name
#   environment   = local.environment
#   aws_region    = var.aws_region

#   db_engine           = var.db_engine
#   db_engine_version   = var.db_engine_version
#   db_instance_class   = var.db_instance_class
#   db_name             = var.db_name
#   db_username         = var.db_username
#   db_password         = var.db_password
#   subnet_ids          = module.vpc.public_subnet_ids
#   vpc_security_group_ids = [module.security_group.rds_sg_id]

#   tags = {
#     Environment = local.environment
#     Project     = var.project_name
#   }
# }
