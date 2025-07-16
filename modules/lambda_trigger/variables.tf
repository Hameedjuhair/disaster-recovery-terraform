variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN to trigger Lambda"
  type        = string
}
