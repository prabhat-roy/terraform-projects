resource "google_compute_subnetwork" "public_subnet" {
  name                     = "public-subnet"
  ip_cidr_range            = var.gcp_cidr[0]
  region                   = var.gcp_region
  network                  = google_compute_network.gcp-vpc.name
  private_ip_google_access = true
}
resource "google_compute_subnetwork" "private_subnet" {
  name                     = "private-subnet"
  ip_cidr_range            = var.gcp_cidr[1]
  region                   = var.gcp_region
  network                  = google_compute_network.gcp-vpc.name
  private_ip_google_access = true
}

