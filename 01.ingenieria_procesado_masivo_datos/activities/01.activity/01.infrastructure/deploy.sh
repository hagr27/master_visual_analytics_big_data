#!/bin/bash
# ===============================
# Script de despliegue automático
# ===============================

set -e  # Detener ejecución si ocurre algún error


source .env

# Volver al directorio de Terraform
cd ./terraform

echo "Inicializando Terraform..."
terraform init

echo "Generando plan de Terraform..."
terraform plan

echo "Aplicando Terraform..."
terraform apply -auto-approve

echo "Despliegue completado."
