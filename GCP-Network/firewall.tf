resource "google_compute_firewall" "allow-80" {
  name          = "allow-80"
  network       = google_compute_network.gcp-vpc.id
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = [80]
  }
}

resource "google_compute_firewall" "allow-icmp" {
  name          = "allow-icmp"
  network       = google_compute_network.gcp-vpc.id
  source_ranges = ["0.0.0.0/0"]
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
