
resource "google_compute_subnetwork" "private_subnet" {
  name                     = "private-subnet"
  ip_cidr_range            = var.gcp_cidr
  region                   = var.gcp_region
  network                  = google_compute_network.gcp-vpc.name
  private_ip_google_access = true
}

