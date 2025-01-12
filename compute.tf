resource "google_compute_instance" "admin_vm" {
  name         = "${local.naming_prefix}-admin-vm"
  zone         = var.gcp_zone
  machine_type = "e2-micro"
  labels       = local.common_tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.custom-vpc.id
    subnetwork = google_compute_subnetwork.vpc-subnet.id
  }
}