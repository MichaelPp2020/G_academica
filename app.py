from flask import Flask, render_template, request, redirect, url_for,make_response, flash
from flask import Flask, send_file
import subprocess
import mysql.connector
from flask import send_file
from flask import request
from flask import render_template
import mysql.connector
import pdfkit
from pdfkit.api import configuration
import datetime
import os
import tempfile






app = Flask(__name__)
app.secret_key = 'your_secret_key_here'

def db_connect():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='admin',
        database='G_Academica'
    )

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/create_user', methods=['POST'])
def create_user():
    username = request.form['username']
    password = request.form['password']
    conn = db_connect()
    cursor = conn.cursor()
    try:
        cursor.execute(f"CREATE USER '{username}'@'localhost' IDENTIFIED BY '{password}';")
        conn.commit()
        flash('Usuario creado con éxito!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error al crear usuario: {str(err)}', 'error')
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/modify_user', methods=['POST'])
def modify_user():
    old_username = request.form['old_username']
    new_username = request.form['new_username']
    new_password = request.form['new_password']
    conn = db_connect()
    cursor = conn.cursor()
    try:
        cursor.execute(f"RENAME USER '{old_username}'@'localhost' TO '{new_username}'@'localhost';")
        cursor.execute(f"ALTER USER '{new_username}'@'localhost' IDENTIFIED BY '{new_password}';")
        conn.commit()
        flash('Usuario modificado con éxito!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error al modificar usuario: {str(err)}', 'error')
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/delete_user', methods=['POST'])
def delete_user():
    username = request.form['username']
    conn = db_connect()
    cursor = conn.cursor()
    try:
        cursor.execute(f"DROP USER IF EXISTS '{username}'@'localhost';")
        conn.commit()
        flash('Usuario eliminado con éxito!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error al eliminar usuario: {str(err)}', 'error')
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/create_role', methods=['POST'])
def create_role():
    role_name = request.form['role_name']
    conn = db_connect()
    cursor = conn.cursor()
    try:
        cursor.execute(f"CREATE ROLE {role_name};")
        conn.commit()
        flash('Rol creado con éxito!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error al crear rol: {str(err)}', 'error')
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/assign_role', methods=['POST'])
def assign_privileges():
    username = request.form['username']
    privileges = request.form.getlist('privileges')  # Esto asume que los privilegios se envían como una lista en el formulario
    conn = db_connect()
    cursor = conn.cursor()
    try:
        for privilege in privileges:
            cursor.execute(f"GRANT {privilege} ON *.* TO '{username}'@'localhost';")
        conn.commit()
        flash('Privilegios asignados con éxito!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error al asignar privilegios: {str(err)}', 'error')
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/delete_role', methods=['POST'])
def delete_role():
    role_name = request.form['role_name']
    conn = db_connect()
    cursor = conn.cursor()
    try:
        cursor.execute(f"DROP ROLE IF EXISTS {role_name};")
        conn.commit()
        flash('Rol eliminado con éxito!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error al eliminar rol: {str(err)}', 'error')
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/get_users', methods=['GET'])
def get_users():
    conn = db_connect()
    cursor = conn.cursor()
    cursor.execute("SELECT User FROM mysql.user WHERE Host='localhost';")
    users = [row[0] for row in cursor.fetchall()]
    cursor.close()
    conn.close()
    return render_template('users.html', users=users)

@app.route('/get_roles', methods=['GET'])
def get_roles():
    conn = db_connect()
    cursor = conn.cursor()
    cursor.execute("SELECT role_name FROM roles;")
    roles = [row[0] for row in cursor.fetchall()]
    cursor.close()
    conn.close()
    return render_template('roles.html', roles=roles)


# Ruta para crear un backup
@app.route('/backup', methods=['POST'])
def backup():
    host = 'localhost'
    usuario = 'root'
    contraseña = 'admin'
    nombre_bd = 'G_Academica'
    ruta_guardado = r"C:\Users\PALACIOS\Desktop\Backup"

    # Nombre del archivo de backup basado en la fecha y hora actual
    fecha_actual = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    nombre_archivo = f"{nombre_bd}_{fecha_actual}.sql"
    
    # Comando para crear el backup utilizando mysqldump
    comando = [
        "mysqldump",
        f"--host={host}",
        f"--user={usuario}",
        f"--password={contraseña}",
        nombre_bd,
        f"> {ruta_guardado}\\{nombre_archivo}"  # Utilizamos "\\" para escapar la barra invertida en la ruta de Windows
    ]

    # Ejecutar el comando
    try:
        subprocess.run(" ".join(comando), shell=True, check=True)
        mensaje = "Backup creado exitosamente."
    except subprocess.CalledProcessError as e:
        mensaje = f"Error al crear el backup: {e}"

    return render_template('index.html', mensaje=mensaje)

# Ruta para restaurar un backup@app.route('/restaurar', methods=['POST'])
@app.route('/restaurar', methods=['POST'])
def restaurar():
    host = 'localhost'
    usuario = 'root'
    contraseña = 'admin'
    nombre_bd = 'G_Academica'
    
    # Obtener el archivo de backup enviado por el usuario
    archivo_backup = request.files['archivo_backup']
    
    # Verificar si se envió un archivo
    if archivo_backup.filename == '':
        flash('No se seleccionó ningún archivo.')
        return redirect(url_for('index'))

    # Verificar si el archivo es un archivo SQL
    if archivo_backup.filename.endswith('.sql'):
        # Crear una ruta temporal única para guardar el archivo
        ruta_temporal = os.path.join(tempfile.gettempdir(), archivo_backup.filename)
        archivo_backup.save(ruta_temporal)

        # Comando para restaurar el backup utilizando mysql
        comando = [
            "mysql",
            f"--host={host}",
            f"--user={usuario}",
            f"--password={contraseña}",
            nombre_bd,
            f"< {ruta_temporal}"
        ]

        # Ejecutar el comando
        try:
            os.system(" ".join(comando))
            mensaje = "Restauración completada exitosamente."
            flash(mensaje)
        except Exception as e:
            flash(f"Error al restaurar el backup: {e}")

        # Eliminar el archivo temporal
        os.remove(ruta_temporal)
    else:
        flash('El archivo seleccionado no es un archivo SQL.')

    return redirect(url_for('index'))

@app.route('/list_entities')
def list_entities():
    conn = db_connect()
    cursor = conn.cursor()

    try:
        # Obtener los nombres de las tablas en la base de datos
        cursor.execute("SHOW TABLES;")
        tables = [row[0] for row in cursor.fetchall()]

        # Obtener la información de cada tabla (nombre de la tabla y número de registros)
        entities = []
        for table in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {table};")
            count = cursor.fetchone()[0]
            entities.append((table, count))

        return render_template('entities.html', entities=entities)
    except mysql.connector.Error as err:
        # Manejar errores de conexión o consultas SQL
        return f"Error: {err}"
    finally:
        cursor.close()
        
        conn.close()
@app.route('/entidades')
def entidades():
    try:
        conn = db_connect()
        cursor = conn.cursor()

        # Obtener la lista de tablas en la base de datos
        cursor.execute("SHOW TABLES;")
        tables = [table[0] for table in cursor.fetchall()]
        
        cursor.close()
        conn.close()
        
        return render_template('entidades.html', tables=tables)
    
    except mysql.connector.Error as err:
        return f"Error: {err}"

    
    
@app.route('/list_attributes')
def list_attributes():
    try:
        conn = db_connect()
        cursor = conn.cursor()

        # Obtener la lista de tablas en la base de datos
        cursor.execute("SHOW TABLES;")
        tables = [table[0] for table in cursor.fetchall()]
        
        # Diccionario para almacenar los atributos por entidad
        entity_attributes = {}
        for table in tables:
            cursor.execute(f"SHOW COLUMNS FROM {table};")
            columns = [column[0] for column in cursor.fetchall()]
            entity_attributes[table] = columns
        
        cursor.close()
        conn.close()
        
        return render_template('list_attributes.html', entity_attributes=entity_attributes)
    
    except mysql.connector.Error as err:
        return f"Error: {err}"
    
    
@app.route('/agregar_entidad', methods=['GET', 'POST'])
def agregar_entidad():
    if request.method == 'POST':
        nombre_entidad = request.form['nombre_entidad']
        atributos = request.form['atributos'].split(',')
        atributos_formatados = [f"{atributo.strip()} VARCHAR(255)" for atributo in atributos]
        
        try:
            conn = db_connect()
            cursor = conn.cursor()

            # Crear la tabla para la nueva entidad
            cursor.execute(f"CREATE TABLE {nombre_entidad} ({', '.join(atributos_formatados)});")
            conn.commit()
            
            cursor.close()
            conn.close()
            
            return redirect(url_for('entidades'))
        
        except mysql.connector.Error as err:
            return f"Error: {err}"
    
    return render_template('agregar_entidad.html')



@app.route('/reporte_pdf')
def reporte_pdf():
    conn = db_connect()
    cursor = conn.cursor()
    
    # Obtener las tablas de la base de datos
    cursor.execute("SHOW TABLES;")
    tablas = cursor.fetchall()
    
    # Inicializar un diccionario para las entidades (nombre de las tablas y sus columnas)
    entidades = {}
    
    for tabla in tablas:
        nombre_tabla = tabla[0]
        cursor.execute(f"SHOW COLUMNS FROM {nombre_tabla};")
        columnas = cursor.fetchall()
        # Guardar las columnas como una lista de tuplas en el diccionario
        entidades[nombre_tabla] = columnas
    
    cursor.close()
    conn.close()

    # Renderizar la plantilla HTML, pasando tanto las tablas como las entidades
    rendered = render_template('reporte.html', tablas=tablas, entidades=entidades)

    # Configuración de pdfkit para especificar la ruta del ejecutable de wkhtmltopdf
    config = pdfkit.configuration(wkhtmltopdf='C:/Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe')

    # Generar el PDF utilizando pdfkit
    pdf = pdfkit.from_string(rendered, False, configuration=config)

    # Crear una respuesta y adjuntar el PDF
    response = make_response(pdf)
    response.headers['Content-Type'] = 'application/pdf'
    response.headers['Content-Disposition'] = 'attachment; filename=reporte.pdf'
    
    return response


@app.route('/generar_procedimientos', methods=['GET', 'POST'])
def generar_procedimientos():
    if request.method == 'POST':
        conn = None
        cursor = None
        try:
            conn = db_connect()
            cursor = conn.cursor()

            # Obtener nombres de las tablas de la base de datos G_Academica
            cursor.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'G_Academica'")
            table_names_result = cursor.fetchall()
            table_names = [row[0] for row in table_names_result]

            for table_name in table_names:
                # Obtener la columna de clave primaria
                cursor.execute(f"""
                SELECT COLUMN_NAME
                FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                WHERE TABLE_SCHEMA = 'G_Academica'
                AND TABLE_NAME = '{table_name}'
                AND CONSTRAINT_NAME = 'PRIMARY'
                """)
                primary_key_row = cursor.fetchone()
                if primary_key_row is None:
                    continue  # Si no hay clave primaria, saltar a la siguiente tabla
                primary_key_column = primary_key_row[0]

                # Obtener columnas de la tabla
                cursor.execute(f"""
                SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_SCHEMA = 'G_Academica'
                AND TABLE_NAME = '{table_name}'
                """)
                columns = cursor.fetchall()

                columns_list = []
                columns_list_params = []
                for column in columns:
                    col_name = column[0]
                    col_type = column[1]
                    col_length = column[2]
                    col_precision = column[3]
                    col_scale = column[4]

                    if col_name != primary_key_column:
                        columns_list.append(f'`{col_name}`')
                        if col_type in ('varchar', 'nvarchar', 'char', 'nchar'):
                            columns_list_params.append(f'IN `{col_name}` {col_type}({col_length})')
                        elif col_type in ('decimal', 'numeric'):
                            columns_list_params.append(f'IN `{col_name}` {col_type}({col_precision}, {col_scale})')
                        else:
                            columns_list_params.append(f'IN `{col_name}` {col_type}')

                # Añadir la columna de clave primaria al final de la lista de parámetros
                columns_list_params.append(f'IN `{primary_key_column}` INT')

                columns_list_str = ', '.join(columns_list)
                columns_list_params_str = ', '.join(columns_list_params)

                # Generar procedimientos almacenados
                sp_statements = []

                # Procedimiento almacenado para INSERT
                sp_statements.append(f"""
                CREATE PROCEDURE Insertar{table_name}
                    ({columns_list_params_str})
                BEGIN
                    INSERT INTO `{table_name}` ({columns_list_str}, `{primary_key_column}`)
                    VALUES ({', '.join('@' + col.strip('`') for col in columns_list)}, @{primary_key_column});
                END;
                """)

                # Procedimiento almacenado para UPDATE
                update_set_clause = ', '.join(f'`{col.strip("`")}` = @{col.strip("`")}' for col in columns_list)
                sp_statements.append(f"""
                CREATE PROCEDURE Actualizar{table_name}
                    ({columns_list_params_str})
                BEGIN
                    UPDATE `{table_name}`
                    SET {update_set_clause}
                    WHERE `{primary_key_column}` = @{primary_key_column};
                END;
                """)

                # Procedimiento almacenado para DELETE
                sp_statements.append(f"""
                CREATE PROCEDURE Eliminar{table_name}
                    (IN `{primary_key_column}` INT)
                BEGIN
                    DELETE FROM `{table_name}`
                    WHERE `{primary_key_column}` = @{primary_key_column};
                END;
                """)

                # Procedimiento almacenado para SELECT
                sp_statements.append(f"""
                CREATE PROCEDURE Seleccionar{table_name}()
                BEGIN
                    SELECT * FROM `{table_name}`;
                END;
                """)

                # Ejecutar los procedimientos almacenados
                for sp_statement in sp_statements:
                    cursor.execute(sp_statement)
                    cursor.fetchall()  # Agregar fetchall() para leer todos los resultados

            conn.commit()  # Realizar la confirmación fuera del bucle for

            return "Procedimientos almacenados generados con éxito"
      
        finally:
            if cursor:
                cursor.close()
            if conn:
                conn.close()

    return render_template('generar_procedimientos.html')

           
@app.route('/eliminar_procedimientos', methods=['POST'])
def eliminar_procedimientos():
    conn = None
    cursor = None
    try:
        conn = db_connect()
        cursor = conn.cursor()

        # Obtener todos los procedimientos almacenados en la base de datos
        cursor.execute("""
        SELECT ROUTINE_NAME
        FROM INFORMATION_SCHEMA.ROUTINES
        WHERE ROUTINE_TYPE = 'PROCEDURE'
        AND ROUTINE_SCHEMA = 'G_Academica'
        """)
        procedures = cursor.fetchall()

        # Eliminar cada procedimiento almacenado encontrado
        for procedure in procedures:
            procedure_name = procedure[0]
            cursor.execute(f"DROP PROCEDURE IF EXISTS {procedure_name}")

        conn.commit()
        return "Procedimientos almacenados eliminados con éxito"
    except mysql.connector.Error as e:
        return f"Error al eliminar procedimientos almacenados: {e}"
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == "__main__":
    app.run(debug=True)