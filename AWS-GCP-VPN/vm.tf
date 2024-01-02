resource "google_compute_instance" "vm" {
  name         = "vm"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["gcp-vm"]
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.id
    access_config {
      nat_ip = google_compute_address.vm.address
    }
  }
}
resource "google_compute_address" "vm" {
  name    = "gcp-ip"
  project = var.project_id
  region  = var.gcp_region
}

resource "google_compute_firewall" "allow-icmp" {
  name          = "allow-icmp"
  network       = google_compute_network.gcp-vpc.id
  source_ranges = [var.aws_vpc_cidr]
  allow {
    protocol = "icmp"

  }
}
resource "google_compute_firewall" "allow-ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.gcp-vpc.id
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = [22]
  }
}
