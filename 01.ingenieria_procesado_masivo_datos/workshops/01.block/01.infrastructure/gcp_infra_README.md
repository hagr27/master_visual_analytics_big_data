# Creación de un Clúster Dataproc en Google Cloud  
Guía para la asignatura: Ingeniería y Procesamiento Masivo de Datos


## 1. Introducción

En un entorno real, la creación de un clúster implica instalar manualmente:

- Linux como sistema operativo
- Hadoop (HDFS)
- Spark
- Kafka
- Hive
- JupyterLab

Además, es necesario configurar:

- El NameNode y DataNodes para HDFS
- El Spark Master y los Workers
- Los brokers de Kafka
- Las IPs de cada nodo

En esta práctica utilizaremos **Google Cloud Dataproc**, que automatiza toda esta instalación y configuración.  

Dataproc levanta un clúster temporal “al vuelo”, que se desmantela cuando termina el tiempo establecido.  
Los datos y notebooks se guardarán en **Google Cloud Storage (GCS)**, que sí es persistente.


## **2. Paso a seguir:**

### 2.1. Crear cuenta en Google Cloud

1. Accedemos a: http://cloud.google.com/free  
2. Hacemos clic en "Empezar gratis".
3. Ingresamos:
   - Correo Gmail
   - Datos personales
   - Tarjeta de crédito (NO se cobra nada)

Google nos regala **$300 USD de crédito durante 90 días**, suficiente para la asignatura.


## 2.2. Crear un proyecto en Google Cloud, asignar facturación y configurar una alerta de presupuesto

Antes de poder utilizar Dataproc o cualquier otro servicio de Google Cloud, es necesario:

1. Crear un proyecto nuevo.
2. Asociarlo a una cuenta de facturación (billing account).
3. Configurar una alerta para evitar consumos inesperados.

A continuación se detalla el proceso completo.

---

#### 2.2.1 Crear un nuevo proyecto en Google Cloud

1. Accedemos a la consola: https://console.cloud.google.com/
2. En la parte superior izquierda, hacemos clic en el selector de proyectos.
3. Pulsamos **“Nuevo proyecto”**.
4. Introducimos:
   - **Nombre del proyecto** (ejemplo: `proyecto-master-unir`)
   - **Organización** (si aparece; si no, se deja como está)
   - **Ubicación**: se deja por defecto
5. Pulsamos **Crear**.

El proyecto tardará unos segundos en estar disponible.

---

#### 2.2.2 Asignar una cuenta de facturación (Billing)

Para poder crear un clúster Dataproc, el proyecto debe estar vinculado a una cuenta de facturación.

1. Con el nuevo proyecto seleccionado, ir al menú lateral:
   **Billing (Facturación)**
2. Si aparece un mensaje indicando que “este proyecto no tiene una cuenta de facturación asociada”, pulsamos:
   - **“Link a billing account” (Asociar a cuenta de facturación)**

3. Seleccionamos la cuenta de facturación creada al activar los $300 de crédito gratuito.

> ⚠️ **Importante:** Aunque se requiera tarjeta de crédito, Google NO realiza cargos sin tu autorización.  
> El crédito cubre completamente esta actividad.

---

#### 2.2.3 Crear una alerta de presupuesto (Budget Alert)

Esta alerta es fundamental para evitar consumos inesperados.

1. Con el proyecto seleccionado, ir a:
   **Billing → Budgets & alerts (Presupuestos y alertas)**  
2. Pulsar **CREATE BUDGET**
3. Configurar los siguientes parámetros:

#### **A. Scope (Alcance)**
- Seleccionar **este proyecto**.

#### **B. Budget amount (Monto del presupuesto)**
- Seleccionar: **"Specify amount"**
- Introducir un límite seguro, por ejemplo:
  
![01.alert_billing](../../../resources/static/images/01.block/01.doc_gcp_infra/01.alert_billing.png)

(No gastarás más de 2–3 USD en toda la asignatura).

#### **C. Alerts (Notificaciones)**
Activar los siguientes umbrales:

- 50% del presupuesto
- 80% del presupuesto
- 100% del presupuesto

Google enviará correos automáticos cuando se alcance alguno de estos valores.

4. Pulsar **SAVE**.

![02.budget](../../../resources/static/images/01.block/01.doc_gcp_infra/02.budget.png)

---

#### 2.2.4 Confirmación final

Una vez terminado este proceso, el proyecto queda listo para usar:

✓ Proyecto creado  
✓ Facturación habilitada  
✓ Alertas configuradas  
✓ No hay riesgo de gastos inesperados  

En la siguiente sección continuaremos con la activación de APIs necesarias para Dataproc.


https://console.cloud.google.com/apis/library?project=proyecto-master-unir


- **Se debe activar:** API Cloud Resource Manager


```bash
gcloud beta dataproc clusters create dp-cluster-proc-masivo \
    --enable-component-gateway \
    --bucket bucket-01-proc-masivo \
    --region europe-west1 \
    --master-machine-type n1-standard-2 \
    --master-boot-disk-size 300 \
    --num-workers 2 \
    --worker-machine-type n1-standard-2 \
    --worker-boot-disk-size 300 \
    --image-version 2.1-debian11 \
    --properties spark:spark.jars.packages=org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.2 \
    --optional-components JUPYTER,ZOOKEEPER \
    --max-age 14400s \
    --initialization-actions "gs://goog-dataproc-initialization-actions-europe-west1/kafka/kafka.sh" \
    --project proyecto-master-unir

## comando mejorado:
gcloud beta dataproc clusters create dp-cluster-proc-masivo \
  --project=PROYECTO_MASTER_UNIR \
  --region=europe-west1 \
  --zone=europe-west1-b \
  --bucket=TU_BUCKET \
  --enable-component-gateway \
  --image-version=2.1-debian11 \
  \
  --master-machine-type=n1-standard-4 \
  --master-boot-disk-type=pd-ssd \
  --master-boot-disk-size=200 \
  \
  --num-workers=2 \
  --worker-machine-type=n1-standard-4 \
  --worker-boot-disk-type=pd-ssd \
  --worker-boot-disk-size=200 \
  \
  --properties=spark:spark.jars.packages=org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.2 \
  \
  --initialization-actions=gs://TU_BUCKET/init-actions/kafka.sh \
  --optional-components=JUPYTER,ZOOKEEPER \
  \
  --labels=env=prod,owner=unir,component=dataproc \
  --max-age=14400s
```

Created [https://dataproc.googleapis.com/v1/projects/proyecto-master-unir/regions/europe-west1/clusters/dp-cluster-proc-masivo] Cluster placed in zone [europe-west1-b].

## 3. Activar la API de Dataproc

1. Entramos en la consola: https://console.cloud.google.com/
2. En el buscador superior escribimos: `dataproc`
3. Seleccionamos el servicio Dataproc.
4. Hacemos clic en **Activar API**.

Esto permite que Google Cloud pueda crear clústeres de big data.


## 4. Paso 3: Crear Bucket en Cloud Storage

Navegación en el menú lateral:

**STORAGE → Cloud Storage → Buckets → CREATE**

Configuración del bucket:

- **Nombre**: único en todo Google Cloud.
- **Location type**: Region
- **Location**: europe-west1
- Las demás opciones se dejan por defecto.

Este bucket será nuestro almacenamiento persistente para:

- datasets
- notebooks
- configuraciones

## 5. Paso 4: Crear el clúster Dataproc desde Google Cloud Shell

1. En el menú lateral, ir a:
**BIG DATA → Dataproc → Clusters**
2. Pulsar en el icono de Google Cloud Shell (parte superior derecha).
3. Pegar el siguiente comando en una sola línea, modificando:

- nombrecluster → nombre deseado
- nombrebucket → bucket creado en el paso anterior
- identificadorproyecto → ID del proyecto (formato word-word-number)
- 14400s → tiempo en segundos (ej: 4 h)

**IMPORTANTE:**  
- Comprobar que el comando está en una sola línea.  
- No modificar la región us-west1.  
- Solo cambiar a europe-west2 si us-west1 tiene problemas de recursos.

```bash
gcloud beta dataproc clusters create nombrecluster \
--enable-component-gateway \
--bucket nombrebucket \
--region us-west1 \
--master-machine-type n1-standard-2 \
--master-boot-disk-size 300 \
--num-workers 2 \
--worker-machine-type n1-standard-2 \
--worker-boot-disk-size 300 \
--image-version 2.1-debian11 \
--properties spark:spark.jars.packages=org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.2 \
--optional-components JUPYTER,ZOOKEEPER \
--max-age 14400s \
--initialization-actions 'gs://goog-dataproc-initialization-actions-us-west1/kafka/kafka.sh' \
--project identificadorproyecto
```

## 6. Acceso a JupyterLab desde el clúster

1. Ir al menú: Dataproc → Clusters
2. Esperar a que el clúster aparezca con un círculo verde (estado "Running").
3. Hacer clic en el nombre del clúster.
4. Ir a la pestaña **Web Interfaces**.
5. Hacer clic en **JupyterLab**.

Si aparece un error temporal:
- Esperar unos minutos
- Volver a intentar abrir JupyterLab

## 7. Limpieza y recomendaciones

- El clúster se apagará automáticamente cuando llegue al tiempo indicado con `--max-age`.
- Guardar siempre los notebooks en el bucket de Cloud Storage.
- No almacenar datos sensibles.
- Si vas a dejar de usar el clúster, puedes borrarlo manualmente:

---
## 8. Terraform IaC
- Parametrizar las variables del fichero **.env**, contiene los objetos a crear en **GCP**:
   - GOOGLE_CREDENTIALS="../credentials_gcp.json"
   - PROJECT_ID="proyecto-master-unir"
   - REGION="europe-west1"
   - CLUSTER_NAME="dataproc-proc-masivo"
   - BUCKET_NAME="bucket-proc-masivo"
   - MAX_AGE="14400s"
   - NUM_WORKERS=2
- ejecutar la shell `./deploy.sh`

- Desde la consola ubicarse donde se encuentra la shell de orquestación
   ```bash
   # Desplegar
   ./deploy.sh
   
   # Destruir 
   ./script.sh destroy
   ```

## 9. Fin del Notebook

Hemos creado un clúster Dataproc con:

- 1 máster
- 2 workers
- Spark configurado
- Kafka instalado
- HDFS operativo
- JupyterLab disponible

Este entorno es equivalente al clúster físico descrito en la asignatura.
