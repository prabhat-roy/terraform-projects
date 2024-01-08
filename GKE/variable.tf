variable "project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_zone" {
  type    = list(string)
  default = ["asia-south2-a", "asia-south2-b", "asia-south2-c"]
}
variable "cred" {
  default = "key.json"
}

variable "gcp_cidr" {

}

variable "machine_type" {

}

variable "node_count" {
  
}