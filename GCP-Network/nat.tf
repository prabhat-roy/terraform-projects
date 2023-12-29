resource "google_compute_router" "gcp-nat" {
  name    = "gcp-nat"
  region  = var.gcp_region
  network = google_compute_network.gcp-vpc.id
}

resource "google_compute_router_nat" "gcp-nat" {
  name                               = "gcp-nat-router"
  router                             = google_compute_router.gcp-nat.name
  region                             = var.gcp_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}