#!/bin/bash

hacer_respaldo(){
	fecha_actual=$(date +"%Y-%m-%d_%H-%M-%S")
	nombre_archivo="/var/mysql/DBweb/BaseDeDatos_${fecha_actual}.sql"
	mysqldump -h localhost -P 3306 -u adminDB -p uexproyecto > "$nombre_archivo" && echo "Backup completado exitosamente" || echo "Error al realizar el backup"

}
hacer_cargado() {
    carpeta="/var/mysql/DBweb/"

    echo "Archivos SQL disponibles para respaldo:"

    archivos_sql=($(find "$carpeta" -type f -name "*.sql"))

    for ((i=0; i<${#archivos_sql[@]}; i++)); do
        nombre_archivo=$(basename "${archivos_sql[$i]}")
        echo "$i: $nombre_archivo"
    done

    read -p "Seleccione un archivo (por número) o presione Enter para cancelar: " opcion

    if [[ $opcion =~ ^[0-9]+$ && $opcion -ge 0 && $opcion -lt ${#archivos_sql[@]} ]]; then
        archivo_seleccionado="${archivos_sql[$opcion]}"

        mysql -h localhost -P 3306 -u adminDB -p uexproyecto < "$archivo_seleccionado"

        if [ $? -eq 0 ]; then
            echo "Restauración completada. Se utilizó el archivo: $archivo_seleccionado"
        else
            echo "Error al restaurar la base de datos. Verifica la contraseña o revisa el archivo SQL."
        fi
    elif [[ -z $opcion ]]; then
        echo "Operación cancelada por el usuario."
    else
        echo "Entrada no válida. Por favor, ingrese un número válido."
    fi
}

