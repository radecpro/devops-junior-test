output "reserved_ip_address" {
  value = google_compute_global_address.cdn_public_address.address
}