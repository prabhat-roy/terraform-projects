output "public-ip-1" {
  value = aws_instance.public-server[0].public_ip
}
output "public-ip-2" {
  value = aws_instance.public-server[1].public_ip
}
output "public-ip-3" {
  value = aws_instance.public-server[2].public_ip
}