resource "google_container_node_pool" "pool" {
  name       = "pool"
  cluster    = google_container_cluster.cluster.id
  node_count = var.node_count
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    machine_type = var.machine_type
    metadata = {
        disable-legacy-endpoints = "true"
    }
  }
}