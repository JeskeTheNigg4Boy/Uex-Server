#!/bin/bash
clear

listar_usuarios() {
    echo "Usuarios en el servidor:"
    echo "========================"
    echo "Nombre de usuario | Carpeta personal | Grupo"

    while IFS=: read -r username _ uid gid _ home shell; do
        if [ "$gid" -gt 1000 ]; then
            group=$(getent group "$gid" | cut -d: -f1)
            echo "$username | $home | $group" 
        fi
    done < /etc/passwd
}
