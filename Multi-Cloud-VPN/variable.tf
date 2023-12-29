variable "aws_region" {
  default = "ap-south-2"
}
variable "aws_prod_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "aws_public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "aws_private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "aws_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}

variable "google_region" {

}
variable "google_project_id" {
  
}