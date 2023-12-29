variable "project_id" {
  type    = string
  default = "round-cable-405107"
}

variable "gcp_region" {
  type    = string
  default = "asia-south2"
}

variable "gcp_zone" {
  type    = list(string)
  default = ["asia-south2-a", "asia-south2-b", "asia-south2-c"]
}
variable "cred" {
  default = "key.json"
}

variable "private-key" {
  default = "~/.ssh/gcp"
}

variable "public-key" {
  default = "~/.ssh/gcp.pub"
}
variable "gcp_cidr" {
  type    = list(string)
  default = ["172.31.0.0/24", "172.31.1.0/24", "172.31.1.0/24"]
}
variable "gcp_machine_type" {
  type    = string
  default = "e2-small"
}

variable "gcp_image" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}
variable "user" {
  type    = string
  default = "prabh"
}
