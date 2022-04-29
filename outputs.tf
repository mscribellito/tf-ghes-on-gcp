output "external_ip" {
  value = google_compute_instance.github.network_interface[0].access_config[0].nat_ip
}
