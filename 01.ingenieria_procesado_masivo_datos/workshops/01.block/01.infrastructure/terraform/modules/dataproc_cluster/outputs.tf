output "cluster_name" {
  description = "Nombre del clúster Dataproc"
  value       = google_dataproc_cluster.cluster.name
}

output "cluster_url" {
  description = "URL del clúster en la consola de GCP"
  value       = "https://console.cloud.google.com/dataproc/clusters?project=${var.project_id}"
}
