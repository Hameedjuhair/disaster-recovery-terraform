output "instance_id" {
  value = aws_instance.drac_server.id
}

output "public_ip" {
  value = aws_instance.drac_server.public_ip
}
