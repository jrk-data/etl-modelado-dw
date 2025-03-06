from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils.dates import days_ago
from datetime import timedelta
import psycopg2
from psycopg2.extras import execute_values
import pandas as pd
import os
from psycopg2 import sql
import json

# Configuración de la base de datos local
DB_CONFIG = {
    'dbname': 'petshop',
    'user': 'cliengo',
    'password': 'test',
    'host': 'postgres-proyecto',  # or the correct hostname/IP address
    'port': '5432',
}


PATH_DAG = os.getcwd()
CSV_FOLDER_PATH = "/opt/airflow/raw_data"

with open(f"{PATH_DAG}/keys/credenciales.json") as file:
    credenciales = json.load(file)


# Conección a la base de datos alojada en google cloud

DB_CONFIG = {
    "host": credenciales["host"],
    "port": credenciales["port"],
    "dbname": credenciales["dbname"],
    "user": credenciales["user"],
    "password": credenciales["password"],
}


def procesamiento_archivos_csv(**kwargs):
    """
    Recorre la carpeta, lee los archivos CSV y los prepara para su carga en PostgreSQL.
    Los nombres de las columnas se transforman a minúsculas y se reemplazan espacios por guiones bajos.
    Los archivos procesados se mueven a una subcarpeta 'procesado'.
    """
    csv_folder_path = kwargs.get('csv_folder_path')  # Obtener la ruta desde los parámetros
    print(f"Ruta de la carpeta CSV: {csv_folder_path}")
    csv_files = {}
    print(f"1) Procesando archivos CSV en: {csv_folder_path}...")

    # Crear la carpeta 'procesados' si no existe
    processed_folder = os.path.join(csv_folder_path, 'procesados')
    os.makedirs(processed_folder, exist_ok=True)

    for filename in os.listdir(csv_folder_path):
        if filename.endswith(".csv"):
            file_path = os.path.join(csv_folder_path, filename)
            table_name = os.path.splitext(filename)[0].lower()  # Nombre de la tabla = nombre del archivo sin extensión y en minúsculas

            # Leer el archivo con pandas
            df = pd.read_csv(file_path)

            # Transformar los nombres de las columnas
            df.columns = [col.lower().replace(' ', '_') for col in df.columns]

            # Sobrescribir el CSV con los cambios
            df.to_csv(file_path, index=False)

            # Mover el archivo a la carpeta de procesados
            new_file_path = os.path.join(processed_folder, filename)
            os.rename(file_path, new_file_path)

            # Guardar la información de los archivos procesados
            csv_files[table_name] = {'path': new_file_path, 'columns': list(df.columns)}
            print(f"Procesado: {filename} --> {new_file_path}")

    # Guardar la información de los archivos CSV en XComs para la siguiente tarea
    kwargs['ti'].xcom_push(key='csv_files', value=csv_files)


def cargar_csv_a_postgres(schema,**kwargs):
    """
    Toma la información de los archivos CSV desde XComs y carga los datos directamente en PostgreSQL usando COPY.
    """
    schema = schema
    # Recuperar la información de los archivos CSV desde XComs
    csv_files = kwargs['ti'].xcom_pull(key='csv_files')
    # Conectar a Postgres
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()

    # Establecer el esquema de búsqueda
    cursor.execute(f"SET search_path TO {schema};")

    print('Los archivos CSV a insertar son: ', csv_files.keys())
    try:
        # Iterar sobre el diccionario de archivos CSV
        for table_name, file_info in csv_files.items():
            file_path = file_info['path']
            columns = file_info['columns']
            print(f"Cargando datos en la tabla {table_name} desde {file_path}...")

            # Crear la consulta COPY
            copy_query = sql.SQL("COPY {} ({}) FROM STDIN WITH CSV HEADER").format(
                sql.Identifier(table_name),
                sql.SQL(', ').join(map(sql.Identifier, columns))
            )
            # Abrir el archivo CSV y cargarlo usando COPY
            with open(file_path, 'r') as f:
                cursor.copy_expert(copy_query, f)
                print(f"Datos cargados en la tabla {table_name}.")

            # Confirmar los cambios en la base de datos
            conn.commit()
    except Exception as e:
        print(f"Error: {e}")
        conn.rollback()  # Revertir cambios en caso de error
    finally:
        if conn:
            cursor.close()
            conn.close()
            print("Conexión cerrada.")



# funcion para conectarse a la bbdd y ejecutar un insert en la tabla 
def insertar_disparador_trigger(schema,DB_CONFIG):
    """
    Conecta a la base de datos y ejecuta un procedimiento almacenado.
    """
    print("Conectando a la base de datos...")
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()
    cursor.execute(f"""insert into {schema}.ultima_fecha_ingesta (proceso, fecha_hora) 
                   values( 'fin_stg_ingesta', now());
                   ;""")
    conn.commit()
    print("Procedimiento almacenado ejecutado.")
    cursor.close()
    conn.close()
    print("Conexión cerrada.")


# Definir el DAG

dag = DAG(
    'etl_pipeline',
    default_args={
        'start_date': days_ago(1),
        'retries': 1,
        #'retry_delay': timedelta(minutes=5),
    },
    schedule_interval='@daily',  # Ejecutar diariamente
    catchup=False,
)


# Tarea 1: Procesar archivos CSV
procesamiento_csv_task = PythonOperator(
    task_id='procesamiento_archivos_csv',
    python_callable=procesamiento_archivos_csv,
    op_kwargs={'csv_folder_path': CSV_FOLDER_PATH},  # Pasar la ruta como parámetro
    provide_context=True,
    dag=dag,
)

# Tarea 2: Crear tablas en Postgres y cargar datos
cargar_stg_tablas_task = PythonOperator(
    task_id='cargar_csv_a_postgres',
    python_callable=cargar_csv_a_postgres,
    op_kwargs={'schema': 'stg'},
    provide_context=True,
    dag=dag,
)

# Tarea 3: Conectar a la base de datos e insertar mensaje fin_stg_ingesta
ejecutar_sp_task = PythonOperator(
    task_id='insertar_disparador_trigger',
    python_callable=insertar_disparador_trigger,
    op_kwargs={
        'schema': 'ods',
        'DB_CONFIG': DB_CONFIG,
        },
    provide_context=True,
    dag=dag,
)


# Ejecutar las tareas en orden
#process_task >> create_tables_task >> select_task

procesamiento_csv_task >> cargar_stg_tablas_task  >>  ejecutar_sp_task
