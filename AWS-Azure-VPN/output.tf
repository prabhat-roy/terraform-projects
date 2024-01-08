output "aws-ec2-public-ip" {
  value = aws_instance.public-server.public_ip
}

output "aws-ec2-private-ip" {
  value = aws_instance.public-server.private_ip
}

