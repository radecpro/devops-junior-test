resource "google_compute_instance" "admin_vm" {
  name         = "${local.naming_prefix}-admin-vm"
  zone         = var.gcp_zone
  machine_type = "e2-micro"
  labels       = local.common_tags
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.custom-vpc.id
    subnetwork = google_compute_subnetwork.vpc-subnet.id
  }

  service_account {
    email  = google_service_account.website_admin.email
    scopes = [ "https://www.googleapis.com/auth/cloud-platform" ]
  }
}

resource "google_service_account" "website_admin" {
  account_id   = "${local.naming_prefix}-website-admin-sa"
  display_name = "Website Admin Service Account"
}
