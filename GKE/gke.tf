resource "google_container_cluster" "cluster" {
  name                     = "gke-cluster"
  location                 = var.gcp_region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.gcp-vpc.name
  subnetwork = google_compute_subnetwork.private_subnet.name
  deletion_protection = false
}