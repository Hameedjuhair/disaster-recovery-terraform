# 📦 Subnet Group for RDS
resource "aws_db_subnet_group" "main" {
  name       = "${var.project}-${var.environment}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.project}-${var.environment}-subnet-group"
    Environment = var.environment
  }
}

# 🛢️ RDS Instance
resource "aws_db_instance" "main" {
  identifier              = "${var.project}-${var.environment}-db"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [var.sg_id]
  skip_final_snapshot     = !var.enable_snapshot
  publicly_accessible     = true
  deletion_protection     = false
  multi_az                = false

  tags = {
    Name        = "${var.project}-${var.environment}-rds"
    Environment = var.environment
  }
}

# 📊 CloudWatch Alarm for RDS FreeStorageSpace
resource "aws_cloudwatch_metric_alarm" "rds_unavailable" {
  alarm_name          = "${var.project}-${var.environment}-rds-low-storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 1000000000  # 1 GB
  alarm_actions = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }

  treat_missing_data = "breaching"
  

  tags = {
    Name        = "${var.project}-${var.environment}-rds-low-storage-alarm"
    Environment = var.environment
  }
}
