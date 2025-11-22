# Recurso que crea un clúster de Dataproc en Google Cloud.
resource "google_dataproc_cluster" "cluster" {
  # Nombre del clúster (definido por variable)
  name   = var.cluster_name

  # Región donde se desplegará el clúster
  region = var.region

  # Proyecto de Google Cloud donde se creará el clúster
  project = var.project_id

  # Configuración del clúster
  cluster_config {

    # Configuración del nodo maestro
    master_config {
      num_instances = 1                     # Siempre un nodo maestro
      machine_type  = "n1-standard-2"      # Tipo de máquina estándar
      disk_config {
        boot_disk_size_gb = 300            # Tamaño del disco del nodo maestro
      }
    }

    # Configuración de los nodos workers
    worker_config {
      num_instances = var.num_workers       # Número de nodos worker definido por variable
      machine_type  = "n1-standard-2"      # Tipo de máquina estándar
      disk_config {
        boot_disk_size_gb = 300            # Tamaño del disco de los workers
      }
    }

    # Configuración adicional de GCE
    gce_cluster_config {
      metadata = {
        "JUPYTER" = "ENABLED"             # Habilita JupyterLab en el clúster
      }
    }

    # Configuración del software del clúster
    software_config {
      image_version = "2.1-debian11"       # Versión de la imagen del clúster
      optional_components = ["JUPYTER", "ZOOKEEPER"] # Componentes opcionales
      properties = {
        # Paquete de Spark necesario para Kafka
        "spark:spark.jars.packages" = "org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.2"
      }
    }

    # Acción de inicialización al crear el clúster
    initialization_action {
      script = "gs://goog-dataproc-initialization-actions-${var.region}/kafka/kafka.sh"
      # Script oficial de Google para inicializar Kafka
    }
  }

  # Ignora cambios en la acción de inicialización para no recrear el clúster cada vez que cambie
  lifecycle {
    ignore_changes = [cluster_config[0].initialization_action]
  }
}
