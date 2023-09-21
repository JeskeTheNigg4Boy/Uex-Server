#!/bin/bash
source funciones.sh
eliminar_usuario(){
	read -p "Ingrese el usuario a eliminar: " username

	while [[ -n "username" ]] && ! verificar_usuario "$username"; do
                echo "El usuario '$username' no existe."
                read -p "Ingrese otro nombre de usuario. (Dejar en blanco para continuar) " username
	done

        if  [[ -n "$username" ]]; then
                sudo userdel -r "$username"
                echo "El usuario $username ha sido eliminado del sistema"
        else
                echo "Operacion cancelada."
        fi
}
