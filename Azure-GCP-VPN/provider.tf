terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.10.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "google" {
  project     = var.project_id
  region      = var.gcp_region
  credentials = var.cred
}
