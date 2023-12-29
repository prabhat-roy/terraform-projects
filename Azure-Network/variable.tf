variable "location" {
  default     = "Central India"
  description = "Location where resources will be created"
}
variable "tags" {
  description = "Map of the tags to use for the resources that are deployed"
  type        = map(string)
  default = {
    environment = "Home"
  }
}

variable "application_port" {
  description = "HTTP Port that you want to expose to the external load balancer"
  default     = 80
}

variable "admin_user" {
  description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
  default     = "usr"
}

variable "admin_password" {
  description = "Default password for admin account"
  default     = "Password@123"
}
variable "size" {
  default = "Standard_B1s"
}
resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  number  = false
}