# Nombre del bucket de Google Cloud Storage que se va a crear.
# Debe ser único a nivel global en GCP.
variable "bucket_name" {
  description = "Nombre del bucket de GCS"
}

# Región de Google Cloud donde se creará el bucket y el clúster.
# Ejemplo: "europe-west1"
variable "region" {
  description = "Región de GCP donde se desplegarán los recursos"
}

# ID del proyecto de Google Cloud donde se desplegarán los recursos.
# No es el nombre del proyecto, sino el identificador tipo: 'mi-proyecto-123456'.
variable "project_id" {
  description = "ID del proyecto de Google Cloud"
}