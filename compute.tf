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
    access_config { }
  }

  service_account {
    email  = google_service_account.website_admin.email
    scopes = [ "https://www.googleapis.com/auth/cloud-platform" ]
  }

  metadata_startup_script = <<EOF
#!/bin/bash
sudo -E bash -c '
  # Install dependencies
  apt-get update
  apt-get install -y python3-pip python3-venv google-cloud-sdk screen

  # Create a virtual environment for Python
  mkdir -p /opt/my-app
  python3 -m venv /opt/my-app/venv

  # Activate the virtual environment and install Python packages
  source /opt/my-app/venv/bin/activate
  pip install --upgrade pip
  pip install Flask google-cloud-storage

  # Copy the application code
  gcloud storage cp gs://bara-website-content/application/app.py /opt/my-app/
  gcloud storage cp -r gs://bara-website-content/application/templates /opt/my-app/

  # Run the application in a detached screen session
  screen -dmS my-app-screen bash -c "cd /opt/my-app && source venv/bin/activate && python3 app.py"
'
EOF
}

resource "google_service_account" "website_admin" {
  account_id   = "${local.naming_prefix}-website-admin-sa"
  display_name = "Website Admin Service Account"
}
