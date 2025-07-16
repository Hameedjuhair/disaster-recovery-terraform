variable "subnet_ids" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "enable_snapshot" {
  type = bool
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}
variable "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  type        = string
}
variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
}
