resource "google_compute_instance" "vm1" {
  name         = "gcp-vm-1"
  machine_type = var.gcp_machine_type
  zone         = var.gcp_zone[0]
  boot_disk {
    initialize_params {
      image = var.gcp_image
    }
  }
  metadata = {
    ssh-keys = "${var.user}:${file(var.public-key)}"
  }
  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.id
    access_config {
      nat_ip = google_compute_address.vm-1.address
    }
  }
}

resource "google_compute_address" "vm-1" {
  name    = "vm-1-ip"
  project = var.project_id
  region  = var.gcp_region
}