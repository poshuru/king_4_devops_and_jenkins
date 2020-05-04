output "cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "The base URL of the API server on the Kubernetes master node"
}

output "client_certificate" {
  value = google_container_cluster.primary.master_auth.0.client_certificate
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate 
}

output "client_key" {
  value = google_container_cluster.primary.master_auth.0.client_key
}