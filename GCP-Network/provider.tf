terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.10.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "5.10.0"
    }
  }
}
provider "google" {
  project     = var.project_id
  region      = var.gcp_region
  credentials = var.cred
}
