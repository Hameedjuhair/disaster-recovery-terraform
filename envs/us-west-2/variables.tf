variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "project_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}
variable "db_engine" {
  default = "mysql"
}

variable "db_engine_version" {
  default = "8.0"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_name" {
  default = "appdb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  sensitive = true
}
