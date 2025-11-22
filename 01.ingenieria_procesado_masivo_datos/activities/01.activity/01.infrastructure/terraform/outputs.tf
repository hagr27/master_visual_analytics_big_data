##############################################
# OUTPUTS
##############################################

# Output que devuelve el nombre del bucket de GCS creado por el módulo.
# Permite usar este valor en otros módulos, scripts o simplemente visualizarlo después de `terraform apply`.
output "bucket_name" {
  value = module.gcs_bucket.bucket_name
}

# Output que devuelve el nombre del clúster de Dataproc creado por el módulo.
# Permite usar este valor en otros módulos, scripts o visualizarlo después de `terraform apply`.
output "cluster_name" {
  value = module.dataproc_cluster.cluster_name
}
