#!/bin/bash

get_group_owner() {
        local directory=$1
        if [ -d "$directory" ]; then
            ls -ld "$directory" | awk '{print $3}'
        else
            echo "Directorio no encontrado"
        fi
}

get_group_users() {
        local group_name=$1
        awk -F: -v group_name="$group_name" '{ if ($1 == group_name) print $4 }' /etc/group | tr ',' '\n'
}

group_list=$(awk -F: '$3 > 1000 {print $1}' /etc/group)

if [ -z "$group_list" ]; then
        echo "No se encontraron grupos en el sistema."
else
        output=""
        for group in $group_list; do
                directory="/home/$group"
                owner=$(get_group_owner "$directory")
                users=$(get_group_users "$group")

                output+="Grupo: $group"$'\n'
                output+="Propietario: $owner"$'\n'
                output+="Usuarios asociados:"$'\n'
                output+="$users"$'\n'
                output+="----------------------"$'\n'
        done

        echo "$output" | less  # Utiliza el comando less para navegar por la salida completa
fi
