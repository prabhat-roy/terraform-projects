aws_region           = "ap-south-2"
aws_vpc_cidr         = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
azs                  = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
aws_instance         = "t3.micro"
aws_ami              = "ami-0bbc2f7f6287d5ca6"
