module "aws_vpc" {
  source = "./aws/vpc"

  vpc_name     = "AWS VPC"
  cidr_block   = var.aws_prod_vpc_cidr
  subnet_count = 1
}
