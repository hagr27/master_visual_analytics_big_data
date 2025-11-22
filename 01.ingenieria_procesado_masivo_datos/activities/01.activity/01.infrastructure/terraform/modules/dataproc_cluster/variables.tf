# Nombre que se le dará al clúster de Dataproc.
variable "cluster_name" {
  description = "Nombre del clúster de Dataproc que se va a crear"
}

# Región de Google Cloud donde se desplegarán los recursos.
variable "region" {
  description = "Región de GCP donde se crearán el bucket y el clúster"
}

# Identificador del proyecto de Google Cloud.
variable "project_id" {
  description = "ID del proyecto de Google Cloud donde se desplegarán los recursos"
}

# Número de instancias worker que tendrá el clúster de Dataproc.
variable "num_workers" {
  type        = number
  description = "Cantidad de nodos worker para el clúster de Dataproc"
}
