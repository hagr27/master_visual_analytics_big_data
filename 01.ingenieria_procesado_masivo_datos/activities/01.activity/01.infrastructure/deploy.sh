#!/bin/bash
# ===============================
# Script de despliegue automático
# ===============================

set -e  # Detener ejecución si ocurre algún error

# Ruta de la función
FUNCTION_DIR="./elt_kaggle_function"
ZIP_FILE="function.zip"

echo "Comprimendo la función en ${ZIP_FILE}..."
cd "$FUNCTION_DIR"

# Comprimir solo main.py y requirements.txt
zip -r "$ZIP_FILE" main.py requirements.txt

echo "Función comprimida correctamente."

# Volver al directorio de Terraform
cd ../terraform

echo "Inicializando Terraform..."
terraform init

echo "Generando plan de Terraform..."
terraform plan

echo "Aplicando Terraform..."
terraform apply -auto-approve

echo "Despliegue completado."
