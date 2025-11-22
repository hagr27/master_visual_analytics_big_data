##############################################
# VARIABLES GLOBALES
##############################################

# Archivo JSON con las credenciales del service account de Google Cloud.
# Se descarga desde Google Cloud IAM → Service Accounts → Create Key.
variable "credentials_file" {
  description = "Archivo JSON con credenciales de GCP"
}

# ID del proyecto de Google Cloud donde se desplegarán los recursos.
# No es el nombre del proyecto, sino el identificador tipo: 'mi-proyecto-123456'.
variable "project_id" {
  description = "ID del proyecto de Google Cloud"
}

# Región de Google Cloud donde se crearán los recursos.
# Ejemplo: "europe-west1"
variable "region" {
  description = "Región de GCP donde se desplegarán los recursos"
}

# Nombre del clúster de Dataproc que se va a crear.
variable "cluster_name" {
  description = "Nombre del clúster de Dataproc"
}

# Nombre del bucket de Google Cloud Storage que se va a crear.
# Debe ser único a nivel global en GCP.
variable "bucket_name" {
  description = "Nombre del bucket de GCS"
}

# Tiempo máximo que el clúster de Dataproc puede estar activo.
# Ejemplo: "14400s" (4 horas)
variable "max_age" {
  description = "Tiempo máximo que el clúster de Dataproc puede estar activo"
}

# Número de nodos worker en el clúster de Dataproc.
# Por defecto se asignan 2 nodos.
variable "num_workers" {
  type        = number
  default     = 2
  description = "Cantidad de nodos worker para el clúster de Dataproc"
}
