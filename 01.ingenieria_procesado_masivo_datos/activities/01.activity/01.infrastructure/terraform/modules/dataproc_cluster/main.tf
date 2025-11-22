resource "google_dataproc_cluster" "cluster" {
  name    = var.cluster_name
  region  = var.region
  project = var.project_id

  cluster_config {

    endpoint_config {
      enable_http_port_access = true
    }

    master_config {
      num_instances = 1
      machine_type  = "n1-standard-2"
      disk_config {
        boot_disk_size_gb = 300
      }
    }

    worker_config {
      num_instances = var.num_workers
      machine_type  = "n1-standard-2"
      disk_config {
        boot_disk_size_gb = 300
      }
    }

    gce_cluster_config {
      metadata = {
        "JUPYTER" = "ENABLED"
      }
    }

    software_config {
      image_version        = "2.1-debian11"
      optional_components  = ["JUPYTER", "ZOOKEEPER"]
    }

    initialization_action {
      script = "gs://goog-dataproc-initialization-actions-${var.region}/kafka/kafka.sh"
    }
  }

  lifecycle {
    ignore_changes = [cluster_config[0].initialization_action]
  }
}
