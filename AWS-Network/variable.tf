variable "aws_region" {
  default = "ap-south-2"
}

variable "prod_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}
variable "aws_instance" {
  type = string
  default = "t2.micro"
}
variable "aws_ami" {
  type = string
  
}