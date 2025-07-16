locals {
  environment = "prod"
}

module "vpc" {
  source      = "../../modules/vpc"
  aws_region  = var.aws_region
  environment = local.environment
  project     = var.project_name
}

module "security_group" {
  source      = "../../modules/security_group"
  environment = local.environment
  project     = var.project_name
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source      = "../../modules/ec2"
  aws_region  = var.aws_region
  environment = local.environment
  project     = var.project_name

  # ✅ Use the first subnet only for EC2
  subnet_id   = module.vpc.subnet_ids[0]
  sg_id       = module.security_group.sg_id
}

module "s3_backup" {
  source      = "../../modules/s3"
  project     = var.project_name
  environment = local.environment
}

module "rds" {
  source              = "../../modules/rds"
  project             = var.project_name
  environment         = local.environment
  subnet_ids          = module.vpc.subnet_ids
  sg_id               = module.security_group.sg_id
  db_username         = var.db_username
  db_password         = var.db_password
  enable_snapshot     = true
  sns_topic_arn       = module.monitoring.sns_topic_arn
  aws_region          = var.aws_region         # ✅ ADD THIS
}


module "monitoring" {
  source          = "../../modules/monitoring"
  project         = var.project_name
  environment     = local.environment
  rds_instance_id = module.rds.db_instance_id
  alert_email     = var.alert_email
}

module "lambda_trigger" {
  source         = "../../modules/lambda_trigger"
  project        = var.project_name
  environment    = local.environment
  sns_topic_arn  = module.monitoring.sns_topic_arn
}
