# Static IP of load balancer
output "reserved_ip_address" {
  value = google_compute_global_address.cdn_public_address.address
}

# External IP of Admin VM
output "admin_vm_ip_address" {
  value = google_compute_instance.admin_vm.network_interface[0].access_config[0].nat_ip
}