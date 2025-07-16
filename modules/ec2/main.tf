resource "aws_instance" "drac_server" {
  ami                         = "ami-0c101f26f147fa7fd"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]

  tags = {
    Name        = "${var.project}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project
  }
}
