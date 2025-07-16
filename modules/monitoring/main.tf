resource "aws_sns_topic" "dr_topic" {
  name = "${var.project}-${var.environment}-dr-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.dr_topic.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "rds_unavailable" {
  alarm_name          = "${var.project}-${var.environment}-rds-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.dr_topic.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }
}
