resource "google_compute_backend_bucket" "static_website" {
  name        = "${local.naming_prefix}-website-backend"
  bucket_name = google_storage_bucket.website_content.name
  enable_cdn  = true
}

resource "google_compute_url_map" "cdn_url_map" {
  name            = "${local.naming_prefix}-cdn-url-map"
  default_service = google_compute_backend_bucket.static_website.self_link
}

resource "google_compute_target_http_proxy" "cdn_http_proxy" {
  name    = "${local.naming_prefix}-cdn-http-proxy"
  url_map = google_compute_url_map.cdn_url_map.self_link
}

resource "google_compute_global_address" "cdn_public_address" {
  name         = "${local.naming_prefix}-cdn-public-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
  labels       = local.common_tags
}

resource "google_compute_global_forwarding_rule" "cdn_global_forwarding_rule" {
  name       = "${local.naming_prefix}-cdn-global-forwarding-https-rule"
  target     = google_compute_target_http_proxy.cdn_http_proxy.self_link
  ip_address = google_compute_global_address.cdn_public_address.address
  port_range = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol = "TCP"
}