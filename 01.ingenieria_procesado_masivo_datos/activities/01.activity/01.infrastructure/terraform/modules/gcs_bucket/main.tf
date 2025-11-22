# Recurso que crea un bucket de Google Cloud Storage (GCS)
resource "google_storage_bucket" "bucket" {
  # Nombre del bucket (definido por variable)
  name     = var.bucket_name

  # Región donde se creará el bucket
  location = var.region

  # Permite eliminar el bucket aunque contenga objetos
  # Útil para limpieza automática durante pruebas o destrucción del entorno
  force_destroy = true

  project = var.project_id
}
