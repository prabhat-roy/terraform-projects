resource "aws_instance" "public-server" {
  ami               = var.ami
  instance_type     = var.aws_instance_type
  subnet_id         = aws_subnet.public_subnet[0].id
  availability_zone = var.azs[0]
  security_groups   = ["${aws_security_group.sg.id}"]
  key_name          = var.kp
  tags = {
    Name = "AWS Server"
  }
}
