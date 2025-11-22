# Output que devuelve el nombre del clúster de Dataproc creado.
# Esto permite usar este valor en otros módulos o simplemente visualizarlo al ejecutar `terraform apply`.
output "cluster_name" {
  value = google_dataproc_cluster.cluster.name
}
