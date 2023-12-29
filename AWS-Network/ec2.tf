resource "aws_instance" "public-server" {
  count           = length(var.azs)
  ami             = var.aws_ami
  instance_type   = var.aws_instance
  subnet_id       = aws_subnet.public_subnet[count.index].id
    availability_zone = var.azs[count.index]
  security_groups = ["${aws_security_group.ssh.id}"]
  key_name        = "Hyd-kp"
  tags = {
    Name = "AWS Public Server ${count.index + 1}"
  }
}

resource "aws_instance" "private-server" {
  count           = length(var.azs)
  ami             = var.aws_ami
  instance_type   = var.aws_instance
  subnet_id       = aws_subnet.private_subnet[count.index].id
  security_groups = ["${aws_security_group.ssh.id}"]
  key_name        = "Hyd-kp"
  tags = {
    Name = "AWS Private Server ${count.index + 1}"
  }
}