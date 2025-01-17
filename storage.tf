# Storage bucket used to store website content
resource "google_storage_bucket" "website_content" {
  name          = "${local.naming_prefix}-website-content"
  location      = var.gcp_region
  labels        = local.common_tags
  storage_class = "STANDARD"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Make bucket public
resource "google_storage_bucket_iam_member" "public_bucket_access" {
  bucket = google_storage_bucket.website_content.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Object admin permissions for service account used in Admin VM
resource "google_storage_bucket_iam_member" "website_admin_access" {
  bucket = google_storage_bucket.website_content.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.website_admin.email}"
}
