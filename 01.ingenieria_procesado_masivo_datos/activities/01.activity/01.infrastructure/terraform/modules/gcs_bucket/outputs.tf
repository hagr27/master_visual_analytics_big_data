##############################################
# OUTPUTS - Bucket de GCS
##############################################

# Nombre del bucket
output "bucket_name" {
  description = "Nombre del bucket de Google Cloud Storage creado."
  value       = google_storage_bucket.bucket.name
}

# URL del bucket en la consola de Google Cloud
output "bucket_url" {
  description = "URL de acceso al bucket en la consola de Google Cloud Storage."
  value       = "https://console.cloud.google.com/storage/browser/${google_storage_bucket.bucket.name}?project=${var.project_id}"
}