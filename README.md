
# Proyecto de Ingesta y Modelado de Datos para un Petshop


## 📌 Descripción del Proyecto
Este proyecto consiste en la ingesta, transformación y modelado de datos provenientes de archivos CSV de un petshop. Se utilizó **Docker, Apache Airflow, Python, PostgreSQL y Cloud SQL** para el procesamiento de datos, y **Looker Studio** para la visualización final.

## 🏗 Arquitectura del Proyecto
1. **Ingesta de Datos**:
   - Los datos son extraídos desde archivos CSV.
   - Se usan contenedores Docker y Apache Airflow para orquestar la ingesta en **Cloud SQL (PostgreSQL)**.

2. **Modelado de Base de Datos**:
   - Se implementa un modelo tipo **medallón** con tres capas:
     - **STG (Stage)**: Ingesta de datos crudos.
     - **ODS (Operational Data Store)**: Transformaciones intermedias.
     - **DW (Data Warehouse)**: Modelo en estrella para análisis y reportes.

3. **Transformaciones**:
   - **ODS**:
     - Estandarización de nombres de columnas y fechas.
     - Registro de **fecha_ingesta** para trazabilidad.
     - Migración de STG a ODS mediante lógica **DELETE-INSERT** con ingesta incremental.
   - **DW**:
     - Modelo en estrella con **dimensiones y tabla de hechos de ventas**.
     - Uso de **Stored Procedures y Triggers** para la migración ODS → DW.
     
<div align="center">
  <img src="https://github.com/jrk-data/etl-modelado-dw/blob/3cee649edbe1f8620b0e063652d44b6551d11f13/img/flujo.png" width="600">
</div>

4. **Visualización en Looker Studio**:
   - Se conecta directamente al DW en Cloud SQL.
   - Se habilitan IPs para conexiones desde Looker Studio y Airflow.
   - **Dashboard disponible en**: [Looker Studio](https://lookerstudio.google.com/u/0/reporting/0ae8bfcb-d3eb-496a-895e-1735ed349c91/page/EBiaE)
  


<div align="center">
	<a href="https://lookerstudio.google.com/u/0/reporting/0ae8bfcb-d3eb-496a-895e-1735ed349c91/page/EBiaE">
		<img src="https://github.com/jrk-data/etl-modelado-dw/blob/3cee649edbe1f8620b0e063652d44b6551d11f13/img/Screenshot%20from%202025-03-05%2022-04-49.png" width="600" >	
	</a>
</div>



## 📊 1era Etapa - Modelo de Datos (STG)
El STG cumple la función de recibir los datos y alojarlo como un **Data Lake**. Se decide guardar todos los campos en formato string para no perder nada en la ingesta a causa de incompatibiilidades de tipo de datos. Y se agrega un campo de _fecha_ingestada_ para tener como seguimiento de ingestas.

 En esta sección nos encontramos con los datos crudos, sucios y sin ningún tipo de transformación. De esta manera nos aseguramos que por el lado del equipo de Data no se pierda ningún dato relevante a futuro.


## 📊 2da Etapa - Modelo de Datos (ODS)
En esta instancia los datos son procesados y estandarizados. Se tomaron los campos que se consideraron relevantes de cada tabla para el modelado final del DW. En esta capa se crearon Store Procedures para llevar a cabo todas las transformaciones correspondientes. 

### `Tabla: ods_articulo`

**Descripción de la tabla:** Tabla que almacena la información de los artículos.

```sql
create table if not exists ods.ods_articulo (
	cla_art int4 NOT NULL,
	codigo varchar(100) NULL,
	nombre varchar(255) NULL,
	ref_prov varchar(100) NULL,
	pvp1 numeric(10, 2) NULL,
	pvp2 numeric(10, 2) NULL,
	pvp1_iva numeric(10, 2) NULL,
	pvp2_iva numeric(10, 2) NULL,
	t_iva int4 NULL,
	pr_ul_com numeric(10, 2) NULL,
	pmp numeric(10, 2) NULL,
	cla_fam int4 NULL,
	pvp_online numeric(10, 2) NULL,
	pvp_oferta numeric(10, 2) NULL,
	oferta int4 NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
,	CONSTRAINT articulo_pkey PRIMARY KEY (cla_art)
);
```
| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_art       | `int4`           | Clave única del artículo.                              |
| codigo        | `varchar(100)`   | Código del artículo.                                   |
| nombre        | `varchar(255)`   | Nombre del artículo.                                   |
| ref_prov      | `varchar(100)`   | Referencia del proveedor.                              |
| pvp1          | `numeric(10, 2)` | Precio de venta al público 1.                          |
| pvp2          | `numeric(10, 2)` | Precio de venta al público 2.                          |
| pvp1_iva      | `numeric(10, 2)` | Precio de venta al público 1 con IVA.                  |
| pvp2_iva      | `numeric(10, 2)` | Precio de venta al público 2 con IVA.                  |
| t_iva         | `int4`           | Tipo de IVA aplicable al artículo.                     |
| pr_ul_com     | `numeric(10, 2)` | Precio de la última compra.                            |
| pmp           | `numeric(10, 2)` | Precio medio ponderado.                                |
| cla_fam       | `int4`           | Clave de la familia a la que pertenece el artículo.     |
| pvp_online    | `numeric(10, 2)` | Precio de venta al público online.                     |
| pvp_oferta    | `numeric(10, 2)` | Precio de venta al público en oferta.                  |
| oferta        | `int4`           | Indicador de si el artículo está en oferta (1) o no (0).|
| _fecha_ingesta| `timestamp`      | Fecha y hora de ingesta del registro.                  |


---

### `Tabla: ods_clientes`
**Descripción de la tabla:** Tabla que almacena la información de los clientes.

```sql
create table if not exists ods.ods_articulo (
	cla_art int4 NOT NULL,
	codigo varchar(100) NULL,
	nombre varchar(255) NULL,
	ref_prov varchar(100) NULL,
	pvp1 numeric(10, 2) NULL,
	pvp2 numeric(10, 2) NULL,
	pvp1_iva numeric(10, 2) NULL,
	pvp2_iva numeric(10, 2) NULL,
	t_iva int4 NULL,
	pr_ul_com numeric(10, 2) NULL,
	pmp numeric(10, 2) NULL,
	cla_fam int4 NULL,
	pvp_online numeric(10, 2) NULL,
	pvp_oferta numeric(10, 2) NULL,
	oferta int4 NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
,	CONSTRAINT articulo_pkey PRIMARY KEY (cla_art)
);
```

| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_cli       | `int4`           | Clave única del cliente.                               |
| codigo        | `int4`           | Código del cliente.                                    |
| nombre        | `varchar(255)`   | Nombre del cliente.                                    |
| provincia     | `varchar(100)`   | Provincia del cliente.                                 |
| postal        | `varchar(20)`    | Código postal del cliente.                             |
| pais          | `varchar(100)`   | País del cliente.                                      |
| fecha_alta    | `date`           | Fecha de alta del cliente.                             |
| regimen_iva   | `int4`           | Régimen de IVA del cliente.                            |
| consumidor    | `int4`           | Indicador de si el cliente es consumidor final (1) o no (0).|
| _fecha_ingesta| `timestamp`      | Fecha y hora de ingesta del registro.                  |


---
### `Tabla: ods_familias`

**Descripción de la tabla:** Tabla que almacena la información de las familias de artículos.

```sql
create table if not exists ods.ods_clientes (
	cla_cli int4 NOT NULL,
	codigo int4 NULL,
	nombre varchar(255) NULL,
	provincia varchar(100) NULL,
	postal varchar(20) NULL,
	pais varchar(100) NULL,
	fecha_alta date NULL,
	regimen_iva int4 NULL,
	consumidor int4 NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP null,
	CONSTRAINT clientes_pkey PRIMARY KEY (cla_cli)
);
```
### Tabla: ods.ods_familia

| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_fam       | `int4`           | Clave única de la familia.                             |
| nom_fam       | `varchar(255)`   | Nombre de la familia.                                  |
| cla_tal       | `int4`           | Clave de la talla asociada a la familia.               |
| cla_parent    | `int4`           | Clave de la familia padre (si existe).                 |
| pvp_online    | `numeric(10, 2)` | Precio de venta al público online.                     |
| pal_clave     | `text`           | Palabras clave asociadas a la familia.                 |
| _fecha_ingesta| `timestamp`      | Fecha y hora de ingesta del registro.                  |






--- 

### `Tabla: ods_linea_ticket`

**Descripción de la tabla:** Tabla que almacena la información de las líneas de los tickets.

```sql
create table if not exists ods.ods_linea_ticket (
	cla_tikl int4 NOT NULL,
	cla_tik int4 NULL,
	cla_art int4 NULL,
	cantidad numeric(10, 2) NULL,
	codigo varchar(50) NULL,
	lin_desc varchar(255) NULL,
	dto numeric(5, 2) NULL,
	iva numeric(5, 2) NULL,
	precio numeric(10, 2) NULL,
	precio_iva numeric(10, 2) NULL,
	vto_garant varchar(50) NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP null,
	CONSTRAINT linea_ticket_pkey PRIMARY KEY (cla_tikl)
);
```


| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_tikl      | `int4`           | Clave única de la línea de ticket.                     |
| cla_tik       | `int4`           | Clave del ticket al que pertenece la línea.            |
| cla_art       | `int4`           | Clave del artículo asociado a la línea.                |
| cantidad      | `numeric(10, 2)` | Cantidad de artículos en la línea.                     |
| codigo        | `varchar(50)`    | Código del artículo en la línea.                       |
| lin_desc      | `varchar(255)`   | Descripción de la línea.                               |
| dto           | `numeric(5, 2)`  | Descuento aplicado en la línea.                        |
| iva           | `numeric(5, 2)`  | IVA aplicado en la línea.                              |
| precio        | `numeric(10, 2)` | Precio unitario del artículo en la línea.              |
| precio_iva    | `numeric(10, 2)` | Precio unitario del artículo con IVA en la línea.      |
| vto_garant    | `varchar(50)`    | Fecha de vencimiento de la garantía (si aplica).       |
| _fecha_ingesta| `timestamp`      | Fecha y hora de ingesta del registro.                  |

--- 
### `Tabla: ods_ticket`

**Descripción de la tabla:** Tabla que almacena la información de los tickets.


```sql
create table if not exists ods.ods_ticket (
	cla_tik int4 NOT NULL,
	cla_emp int4 NULL,
	cla_eje int4 NULL,
	cla_tpv int4 NULL,
	cla_cli int4 NULL,
	cod_cli int4 NULL,
	numero int4 NULL,
	total numeric(10, 2) NULL,
	pagado numeric(10, 2) NULL,
	cla_ven int4 NULL,
	cla_fac int4 NULL,
	prov_cli varchar(100) NULL,
	pos_cli varchar(20) NULL,
	entrega numeric(10, 2) NULL,
	cambio_dev numeric(10, 2) NULL,
	tarjeta numeric(10, 2) NULL,
	fecha_hora timestamp NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP null,
	CONSTRAINT ticket_pkey PRIMARY KEY (cla_tik)
);
```

| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_tik       | `int4`           | Clave única del ticket.                                |
| cla_emp       | `int4`           | Clave de la empresa asociada al ticket.                |
| cla_eje       | `int4`           | Clave del ejercicio asociado al ticket.                |
| cla_tpv       | `int4`           | Clave del TPV (Terminal Punto de Venta) asociado al ticket.|
| cla_cli       | `int4`           | Clave del cliente asociado al ticket.                  |
| cod_cli       | `int4`           | Código del cliente asociado al ticket.                 |
| numero        | `int4`           | Número del ticket.                                     |
| total         | `numeric(10, 2)` | Total del ticket.                                      |
| pagado        | `numeric(10, 2)` | Cantidad pagada en el ticket.                          |
| cla_ven       | `int4`           | Clave del vendedor asociado al ticket.                 |
| cla_fac       | `int4`           | Clave de la factura asociada al ticket (si existe).    |
| prov_cli      | `varchar(100)`   | Provincia del cliente asociado al ticket.              |
| pos_cli       | `varchar(20)`    | Código postal del cliente asociado al ticket.          |
| entrega       | `numeric(10, 2)` | Cantidad entregada en el ticket.                       |
| cambio_dev    | `numeric(10, 2)` | Cambio o devolución en el ticket.                      |
| tarjeta       | `numeric(10, 2)` | Cantidad pagada con tarjeta en el ticket.              |
| fecha_hora    | `timestamp`      | Fecha y hora del ticket.                               |
| _fecha_ingesta| `timestamp`      | Fecha y hora de ingesta del registro.                  |



## 📊 3ra Etapa - Modelo de Datos (DW)
El DW se diseñó bajo un **modelo en estrella**, con las siguientes dimensiones y tabla de hechos:

### 📁 Dimensiones
### `Tabla: dim_clientes`

**Descripción de la tabla:** Dimensión de clientes, almacena información de cada cliente registrado.


```sql
CREATE TABLE dim_clientes (
   cla_cli      INTEGER PRIMARY KEY,
   codigo       INTEGER,            
   nombre       VARCHAR(255),        
   provincia    VARCHAR(100),        
   postal       VARCHAR(20),         
   pais         VARCHAR(100),        
   fecha_alta   DATE,
   regimen_iva  INTEGER,             
   consumidor   BOOLEAN
);

### Tabla: dim_clientes

| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_cli       | `INTEGER`        | Clave única del cliente.                               |
| codigo        | `INTEGER`        | Código del cliente en el sistema.                      |
| nombre        | `VARCHAR(255)`   | Nombre completo del cliente.                           |
| provincia     | `VARCHAR(100)`   | Provincia del cliente.                                 |
| postal        | `VARCHAR(20)`    | Código postal del cliente.                             |
| pais          | `VARCHAR(100)`   | País del cliente.                                      |
| fecha_alta    | `DATE`           | Fecha de alta del cliente.                             |
| regimen_iva   | `INTEGER`        | Régimen de IVA del cliente.                            |
| consumidor    | `BOOLEAN`        | Indica si es consumidor final (TRUE/FALSE).            |


---
```
### `Tabla: dim_familias`

**Descripción de la tabla:** Dimensión de familias de productos.

```sql
CREATE TABLE dim_familias (
   cla_fam      INTEGER PRIMARY KEY,
   nom_fam      VARCHAR(255),        
   cla_tal      INTEGER,             
   pal_clave    TEXT
);
```

| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_fam       | `INTEGER`        | Clave única de la familia.                             |
| nom_fam       | `VARCHAR(255)`   | Nombre de la familia.                                  |
| cla_tal       | `INTEGER`        | Código de la talla asociada.                           |
| pal_clave     | `TEXT`           | Palabras clave relacionadas con la familia.            |


### `Tabla: dim_articulos`

**Descripción de la tabla:** Dimensión de artículos, almacena información de cada producto vendido.

```sql
CREATE TABLE dim_articulos (
   cla_art      INTEGER PRIMARY KEY,
   codigo       VARCHAR(100),        
   nombre       VARCHAR(255),        
   ref_prov     VARCHAR(100),        
   pvp1         NUMERIC(10, 2),      
   pvp2         NUMERIC(10, 2),      
   t_iva        INTEGER,             
   cla_fam      INTEGER REFERENCES dim_familias(cla_fam)
);
```

| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_art       | `INTEGER`        | Clave única del artículo.                              |
| codigo        | `VARCHAR(100)`   | Código del artículo (EAN/UPC o interno).               |
| nombre        | `VARCHAR(255)`   | Nombre descriptivo del artículo.                       |
| ref_prov      | `VARCHAR(100)`   | Referencia del proveedor para el artículo.             |
| pvp1          | `NUMERIC(10, 2)` | Precio de venta al público 1.                          |
| pvp2          | `NUMERIC(10, 2)` | Precio de venta al público 2.                          |
| pvp1_iva      | `NUMERIC(10, 2)` | Precio de venta al público 1 con IVA incluido.         |
| pvp2_iva      | `NUMERIC(10, 2)` | Precio de venta al público 2 con IVA incluido.         |
| t_iva         | `INTEGER`        | Tipo de IVA aplicado al artículo.                      |
| pr_ul_com     | `NUMERIC(10, 2)` | Precio de última compra.                               |
| pmp           | `NUMERIC(10, 2)` | Precio medio ponderado.                                |
| pvp_online    | `NUMERIC(10, 2)` | Precio de venta online.                                |
| pvp_oferta    | `NUMERIC(10, 2)` | Precio de oferta del artículo.                         |
| oferta        | `BOOLEAN`        | Indica si el artículo está en oferta (TRUE/FALSE).     |
| cla_fam       | `INTEGER`        | Clave de la familia a la que pertenece el artículo.    |

---

### `Tabla: dim_ticket`

**Descripción de la tabla:** Dimensión de tickets, almacena información de cada transacción de venta.

```sql
CREATE TABLE dim_ticket (
   cla_tik      INTEGER PRIMARY KEY,
   numero       INTEGER,        
   total        NUMERIC(10, 2),      
   fecha_hora   TIMESTAMP
);
```

| Nombre campo   | Tipo campo        | Descripción campo                                      |
|----------------|------------------|--------------------------------------------------------|
| cla_tik       | `INTEGER`        | Clave única del ticket.                                |
| cla_emp       | `INTEGER`        | Clave de la empresa asociada al ticket.                |
| numero        | `INTEGER`        | Número del ticket.                                     |
| total         | `NUMERIC(10, 2)` | Total de la venta.                                     |
| pagado        | `NUMERIC(10, 2)` | Monto pagado por el cliente.                           |
| cla_tjt       | `INTEGER`        | Clave de la tarjeta utilizada en el pago.              |
| serie_fac     | `VARCHAR(3)`     | Serie de la factura asociada al ticket.                |
| num_fac       | `INTEGER`        | Número de la factura.                                  |
| pago_tarjeta  | `BOOLEAN`        | Indica si el pago fue con tarjeta (TRUE/FALSE).        |
| fecha_hora    | `TIMESTAMP`      | Fecha y hora de la transacción.                        |


---

### 🔥 `Tabla de Hechos: ventas`

**Descripción de la tabla:** Tabla de hechos de ventas, almacena todas las transacciones.

```sql
CREATE TABLE ventas (
   cla_tikl          INTEGER,
   fecha_hora        TIMESTAMP,
   cla_tik          INTEGER REFERENCES dim_ticket(cla_tik),
   cla_cli          INTEGER REFERENCES dim_clientes(cla_cli),
   cla_art          INTEGER REFERENCES dim_articulos(cla_art),
   cla_fam          INTEGER REFERENCES dim_familias(cla_fam),
   cantidad         NUMERIC(10, 2),
   precio           NUMERIC(10, 2),
   precio_iva       NUMERIC(10, 2)
);
```

| Nombre campo                | Tipo campo        | Descripción campo                                      |
|-----------------------------|------------------|--------------------------------------------------------|
| cla_tikl                   | `INTEGER`        | Clave única de la línea de ticket.                     |
| fecha_hora                 | `TIMESTAMP`      | Fecha y hora de la transacción.                        |
| cla_tik                    | `INTEGER`        | Clave del ticket asociado.                             |
| cla_cli                    | `INTEGER`        | Clave del cliente asociado.                            |
| cla_art                    | `INTEGER`        | Clave del artículo asociado.                           |
| cla_fam                    | `INTEGER`        | Clave de la familia asociada.                          |
| cla_tpv                    | `INTEGER`        | Clave del TPV asociado.                                |
| cla_ven                    | `INTEGER`        | Clave del vendedor asociado.                           |
| cantidad                   | `NUMERIC(10, 2)` | Cantidad de artículos vendidos.                        |
| precio                     | `NUMERIC(10, 2)` | Precio unitario del artículo.                          |
| precio_iva                 | `NUMERIC(10, 2)` | Precio unitario del artículo con IVA.                  |
| precio_total_articulos     | `NUMERIC(10, 2)` | Precio total de los artículos sin IVA.                 |
| precio_total_articulos_iva | `NUMERIC(10, 2)` | Precio total de los artículos con IVA.                 |
| tarjeta                    | `BOOLEAN`        | Indica si el pago fue con tarjeta (TRUE/FALSE).        |


---

### Relaciones de la tabla `ventas`:

- **fk_clientes**: Clave foránea que referencia a `dim_clientes(cla_cli)`.
- **fk_articulo**: Clave foránea que referencia a `dim_articulos(cla_art)`.
- **fk_familia**: Clave foránea que referencia a `dim_familias(cla_fam)`.
- **fk_ticket**: Clave foránea que referencia a `dim_ticket(cla_tik)`.
--- 

### DER Modelo estrella final del Data Warehouse


![Image](https://github.com/jrk-data/etl-modelado-dw/blob/3cee649edbe1f8620b0e063652d44b6551d11f13/img/dw.png)


## 🔧 Tecnologías Utilizadas
- **Docker**: Contenerización del entorno.
- **Apache Airflow**: Orquestación de workflows de ingesta y transformación.
- **Python**: Procesamiento y manipulación de datos.
- **PostgreSQL (Cloud SQL)**: Base de datos en la nube.
- **SQL (Stored Procedures y Triggers)**: Transformaciones y migraciones de datos.
- **Looker Studio**: Creación de dashboards.
- **ChatGPT-4 y DeepSeek**: Utilizados para optimizar procesos y mejorar la eficiencia en la documentación y desarrollo del proyecto.

## 🚀 Cómo Ejecutarlo
1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tuusuario/nombre-del-repo.git
   cd nombre-del-repo
   ```
2. **Inicializar Airflow**:
   ```bash
    docker compose up airflow-init
   ```
3. **Levantar los contenedores con Docker**:
   ```bash
   docker-compose up -d
   ```
4. **Acceder a Airflow** y ejecutar los DAGs de ingesta:
   - URL: `http://localhost:8080`
5. **Configurar conexión en Looker Studio**:
   - Conectar a la instancia de Cloud SQL.
   - Crear dashboard con los datos de `dw.ventas`.

## 📈 Resultados y Visualización
- Se creó un **dashboard en Looker Studio** con métricas clave del negocio.
- Se permite análisis de ventas por cliente, productos, familias y ticket.
- Accede al **dashboard aquí**: [Looker Studio](https://lookerstudio.google.com/u/0/reporting/0ae8bfcb-d3eb-496a-895e-1735ed349c91/page/EBiaE)
