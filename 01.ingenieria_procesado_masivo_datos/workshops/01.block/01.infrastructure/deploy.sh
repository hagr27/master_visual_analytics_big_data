#!/bin/bash
# ===============================
# Script de despliegue automático
# ===============================

set -e  # Detener ejecución si ocurre algún error

# Cargar variables del .env y exportarlas como TF_VAR_*
set -a
. .env
set +a

export TF_VAR_project_id="$PROJECT_ID"
export TF_VAR_region="$REGION"
export TF_VAR_cluster_name="$CLUSTER_NAME"
export TF_VAR_bucket_name="$BUCKET_NAME"
export TF_VAR_max_age="$MAX_AGE"
export TF_VAR_credentials_file="$GOOGLE_CREDENTIALS"
export TF_VAR_num_workers="$NUM_WORKERS"

# Ir al directorio de Terraform
cd ./terraform

echo "Inicializando Terraform..."
terraform init

# Verificar si se pasa el argumento "destroy"
if [ "$1" == "destroy" ]; then
    echo "Generando plan de destrucción..."
    terraform plan -destroy
    
    echo "Destruyendo infraestructura..."
    terraform destroy -auto-approve
    
    echo "Destrucción completada."
else
    echo "Generando plan de Terraform..."
    terraform plan
    
    echo "Aplicando Terraform..."
    terraform apply -auto-approve
    
    echo "Despliegue completado."
fi