##############################################
# OUTPUTS - Bucket de GCS
##############################################

# Nombre del bucket
output "bucket_name" {
  description = "Nombre del bucket de Google Cloud Storage creado."
  value       = module.gcs_bucket.bucket_name
}

# URL del bucket en la consola de Google Cloud
output "bucket_url" {
  description = "URL de acceso al bucket en la consola de Google Cloud Storage."
  value       = module.gcs_bucket.bucket_url
}

##############################################
# OUTPUTS - Clúster Dataproc
##############################################

# Nombre del clúster
output "cluster_name" {
  description = "Nombre del clúster"
  value       = module.dataproc_cluster.cluster_name
}

# URL del clúster en la consola de Google Cloud
output "cluster_url" {
  description = "URL del clúster en GCP"
  value       = module.dataproc_cluster.cluster_url
}