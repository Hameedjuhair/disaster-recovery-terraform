resource "aws_s3_bucket" "drac_backup" {
  bucket = "${var.project}-${var.environment}-backup-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "${var.project}-${var.environment}-backup"
    Environment = var.environment
    Project     = var.project
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
