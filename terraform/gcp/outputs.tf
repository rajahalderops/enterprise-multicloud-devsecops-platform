output "network_name" {
  description = "Name of the custom VPC."
  value       = google_compute_network.foundation.name
}

output "network_self_link" {
  description = "Self link of the custom VPC."
  value       = google_compute_network.foundation.self_link
}

output "workload_subnet_name" {
  description = "Name of the workload subnet."
  value       = google_compute_subnetwork.workload.name
}

output "workload_subnet_cidr" {
  description = "CIDR range of the workload subnet."
  value       = google_compute_subnetwork.workload.ip_cidr_range
}
