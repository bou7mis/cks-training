output "project_id" {
  description = "The project id used when managing resources."
  value       = var.project_id
}

output "zone" {
  description = "The region used when managing resources."
  value       = var.zone
}

output "bootstrap_token" {
  description = "kubeadm bootstrap token"
  value       = var.bootstrap_token
}

output "master_ip" {
  description = "kubeadm bootstrap token"
  value       = google_compute_address.master_ip.address
}