resource "google_compute_firewall" "allow-icmp" {
  name          = "allow-icmp"
  network       = google_compute_network.gcp-vpc.id
  source_ranges = [var.aws_vpc_cidr, var.azure_cidr]
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
