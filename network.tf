resource "google_compute_network" "custom-vpc" {
  name                    = "${local.naming_prefix}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc-subnet" {
  name                     = "${local.naming_prefix}-subnet"
  ip_cidr_range            = "192.168.0.0/16"
  region                   = "europe-central2"
  network                  = google_compute_network.custom-vpc.id
  private_ip_google_access = true
}