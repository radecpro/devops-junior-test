resource "google_storage_bucket" "website_content" {
  name          = "${local.naming_prefix}-website-content"
  location      = var.gcp_region
  labels        = local.common_tags
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}