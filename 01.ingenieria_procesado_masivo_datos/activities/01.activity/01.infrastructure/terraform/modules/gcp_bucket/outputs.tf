# Output que devuelve el nombre del bucket de Google Cloud Storage creado.
# Esto permite usar este valor en otros módulos o scripts, 
# o simplemente visualizarlo al ejecutar `terraform apply`.
output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
