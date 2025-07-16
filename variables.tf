variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "disaster-recovery" {
  description = "The project name prefix"
  type        = string
  default     = "drac" # Disaster Recovery as Code
}
variable "db_username" {
  description = "RDS DB username"
  type        = string
}

variable "db_password" {
  description = "RDS DB password"
  type        = string
  sensitive   = true
}
variable "alert_email" {
  description = "Email address for DR alerts"
  type        = string
}
