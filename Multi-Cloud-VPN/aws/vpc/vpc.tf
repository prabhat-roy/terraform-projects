resource "aws_vpc" "prod" {
  cidr_block = var.prod_vpc_cidr
  tags = {
    Name = "Production VPC"
  }
}
