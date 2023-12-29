resource "aws_instance" "public-server" {
  count         = length(var.azs)
  ami           = var.aws_ami
  instance_type = var.aws_instance
  subnet_id = aws_subnet.public[count.index].id
  availability_zone = var.azs[count.index]
  security_groups = ["${aws_security_group.http.id}"]

  user_data = file("data.sh")

  tags = {
    Name = "Public Server - ${count.index + 1}"
  }
}