#!/bin/bash

hacer_respaldo(){
	fecha_actual=$(date +"%Y-%m-%d_%H-%M-%S")
	nombre_archivo="/var/mysql/DBweb/BaseDeDatos_${fecha_actual}.sql"
	mysqldump -h localhost -P 3306 -u AdminDB -p uexproyecto > "$nombre_archivo" && echo "Backup completado exitosamente" || echo "Error al realizar el backup"

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

        mysql -h localhost -P 3306 -u AdminDB -p uexproyecto < "$archivo_seleccionado"

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
actualizar_horarios() {
    MYSQL_ROOT_PASSWORD="password"

    # Crear un archivo temporal para las consultas SQL
    SQL_FILE=$(mktemp)

    # Obtener la fecha y hora actuales
    current_date=$(date +'%Y-%m-%d')
    current_time=$(date -d '+1 hour' +'%H:%M:%S')

    # Consulta inicial para obtener los ID_Horario
    query1="SELECT ID_Horario FROM pertenece_a WHERE Dia_Salida = '$current_date' AND Hora_Salida <= '$current_time';"
    echo "$query1" > "$SQL_FILE"

    # Ejecutar la consulta y guardar resultados en un array
    id_horario_array=($(mysql -u AdminDB -p"$MYSQL_ROOT_PASSWORD" -D uexproyecto < "$SQL_FILE" -N))

    # Iterar sobre el array de ID_Horario
    for id_horario in "${id_horario_array[@]}"; do
        # Consulta para obtener los ID_Reserva
        query2="SELECT existe.ID_Reserva FROM existe JOIN reserva ON existe.ID_Reserva = reserva.ID_Reserva WHERE existe.ID_Horario = $id_horario AND reserva.Estado_Reserva = 'Pendiente';"
        echo "$query2" > "$SQL_FILE"

        # Ejecutar la consulta y guardar resultados en un nuevo array
        id_reserva_array=($(mysql -u AdminDB -p"$MYSQL_ROOT_PASSWORD" -D uexproyecto < "$SQL_FILE" -N))

        # Iterar sobre el array de ID_Reserva
        for id_reserva in "${id_reserva_array[@]}"; do
            # Consulta para cancelar la reserva
            query3="UPDATE reserva SET Estado_Reserva = 'Cancelado' WHERE ID_Reserva = $id_reserva;"
            echo "$query3" > "$SQL_FILE"

            # Ejecutar la consulta de actualización
            mysql -u AdminDB -p"$MYSQL_ROOT_PASSWORD" -D uexproyecto < "$SQL_FILE"

            echo "Reserva $id_reserva cancelada."
        done
    done

    rm "$SQL_FILE"
}

