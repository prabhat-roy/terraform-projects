resource "aws_security_group" "alb" {
  vpc_id      = aws_vpc.int.id
  name        = "ALB"
  description = "Allow ALB Traffic"

  tags = {
    Name = "ALB Security Group"
  }
  ingress {

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}
