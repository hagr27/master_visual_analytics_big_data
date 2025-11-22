##############################################
# CONFIGURACIÓN DEL PROVEEDOR GOOGLE CLOUD
##############################################

# Definición de Terraform y requerimientos de proveedores
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"  # Versión mínima del provider de Google Cloud
    }
  }
}

# Configuración del proveedor Google Cloud
provider "google" {
  credentials = file(var.credentials_file)  # Archivo JSON de credenciales de service account
  project     = var.project_id              # ID del proyecto de GCP
  region      = var.region                  # Región por defecto para los recursos
}

##############################################
# MÓDULO: GOOGLE CLOUD STORAGE (GCS)
##############################################
module "gcs_bucket" {
  source      = "./modules/gcs_bucket"  # Ruta del módulo que crea el bucket
  bucket_name = var.bucket_name         # Nombre del bucket definido por variable
  region      = var.region              # Región donde se creará el bucket
  project_id   = var.project_id         # ID del proyecto de GCP
}

##############################################
# MÓDULO: DATAPROC CLUSTER
##############################################
module "dataproc_cluster" {
  source       = "./modules/dataproc_cluster"  # Ruta del módulo que crea el clúster
  cluster_name = var.cluster_name              # Nombre del clúster
  region       = var.region                    # Región donde se desplegará
  project_id   = var.project_id               # ID del proyecto de GCP
  num_workers  = var.num_workers              # Número de nodos worker
}
