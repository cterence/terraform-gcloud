output "gke_endpoint" {
  value = google_container_cluster.cluster.endpoint
}

output "gke_master_version" {
  value = google_container_cluster.cluster.master_version
}

output "gcloud_get_credentials_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --region ${var.region}"
}
