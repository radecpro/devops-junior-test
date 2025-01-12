resource "google_storage_bucket" "website_content" {
  name          = "${local.naming_prefix}-website-content"
  location      = var.gcp_region
  labels        = local.common_tags
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "website_files" {
  for_each = fileset("${path.module}/website", "**")
  name     = each.value
  bucket   = google_storage_bucket.website_content.name
  source   = "${path.module}/website/${each.value}"
}