#!/bin/bash
actualizar_horarios() {
    MYSQL_ROOT_PASSWORD="password"

    SQL_FILE=$(mktemp)

    current_date=$(date +'%Y-%m-%d')
    current_time=$(date -d '+1 hour' +'%H:%M:%S')

    query1="SELECT ID_Horario FROM pertenece_a WHERE Dia_Salida = '$current_date' AND Hora_Salida <= '$current_time';"
    echo "$query1" > "$SQL_FILE"

    id_horario_array=($(mysql -u adminDB -p"$MYSQL_ROOT_PASSWORD" -D uexproyecto < "$SQL_FILE" -N))

    for id_horario in "${id_horario_array[@]}"; do

        query2="SELECT existe.ID_Reserva FROM existe JOIN reserva ON existe.ID_Reserva = reserva.ID_Reserva WHERE existe.ID_Horario = $id_horario AND reserva.Estado_Reserva = 'Pendiente';"
        echo "$query2" > "$SQL_FILE"

        id_reserva_array=($(mysql -u adminDB -p"$MYSQL_ROOT_PASSWORD" -D uexproyecto < "$SQL_FILE" -N))

        for id_reserva in "${id_reserva_array[@]}"; do
            # Consulta para cancelar la reserva
            query3="UPDATE reserva SET Estado_Reserva = 'Cancelado' WHERE ID_Reserva = $id_reserva;"
            echo "$query3" > "$SQL_FILE"

            mysql -u adminDB -p"$MYSQL_ROOT_PASSWORD" -D uexproyecto < "$SQL_FILE"

            echo "Reserva $id_reserva cancelada."
        done
    done

    rm "$SQL_FILE"
}
actualizar_horarios
