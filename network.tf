# VPC network
resource "google_compute_network" "custom-vpc" {
  name                    = "${local.naming_prefix}-vpc"
  auto_create_subnetworks = false
}

# Subnet in VPC network
resource "google_compute_subnetwork" "vpc-subnet" {
  name                     = "${local.naming_prefix}-subnet"
  ip_cidr_range            = "192.168.0.0/16"
  region                   = "europe-central2"
  network                  = google_compute_network.custom-vpc.id
  private_ip_google_access = true
}

# Firewall rule to allow SSH connection via IAP
resource "google_compute_firewall" "allow-ssh" {
  name    = "${local.naming_prefix}-fw-allow-ssh"
  network = google_compute_network.custom-vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  priority = "995"
  // Connection via IAP for VMs without external IP
  source_ranges = ["35.235.240.0/20"]
}

# Firewall rule to access HTTP website
resource "google_compute_firewall" "allow-http" {
  name    = "${local.naming_prefix}-fw-allow-http"
  network = google_compute_network.custom-vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"] # Or a more restrictive range
}