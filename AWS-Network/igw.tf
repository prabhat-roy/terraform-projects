resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "Internet Gateway"
  }
}

