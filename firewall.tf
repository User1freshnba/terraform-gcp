resource "google_compute_firewall" "default" {
  name          = "allow-http"
  network       = data.google_compute_network.my-network.name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
}