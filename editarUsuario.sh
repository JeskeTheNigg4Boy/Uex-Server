#!/bin/bash
source ./funciones.sh
clear

mostrar_ficha() {
	echo ""
	local username=$1
	echo "Ficha del usuario $username:"
	echo "=========================="
	echo "Nombre de usuario: $username"
	echo "Carpeta personal: $(getent passwd "$username" | cut -d: -f6)"
	echo "Grupo primario: $(id -gn "$username")"
	echo "Grupos secundarios: $(id -Gn "$username" | sed 's/ /, /g')"
}

cambiar_contra() {
	local username=$1
		read -s -p "Ingrese nueva contraseña para el usuario $username: " password
	echo
	while [[ -z $password ]]; do
	echo "Ingrese una contraseña válida."
		read -s -p "Ingrese nueva contraseña para el usuario $username: " password
	echo
	done
	echo "$username:$password" | sudo chpasswd
	echo "La contraseña del usuario $username ha sido cambiada."
}

editar_atributos() {
		read -p "Ingrese nombre de usuario: " username
	while ! verificar_usuario "$username"; do
	echo "El nombre de usuario '$username' no existe."
        	read -p "Ingrese otro nombre de usuario: " username
	done

	mostrar_ficha "$username"

	echo "¿Qué atributos desea cambiar?"
	echo "1) Nombre de usuario"
	echo "2) Carpeta personal"
	echo "3) Grupo primario"
	echo "4) Grupos secundarios"
	echo "5) Contraseña"
	echo "9) Salir"

	read -p "Ingrese la opción deseada: " choice
	case "$choice" in
	1)
		read -p "Ingrese nuevo nombre de usuario: " new_username
	sudo usermod -l "$new_username" "$username"
	echo "El nombre de usuario ha sido actualizado." ;;
        2)
            	read -p "Ingrese nueva carpeta de inicio: " new_home_directory
	sudo usermod -d "/home/$new_home_directory" "$username"
	echo "La carpeta personal ha sido actualizada." ;;
        3)
            	read -p "Ingrese nuevo grupo primario: " new_primary_group
	while ! verificar_grupo "$new_primary_group"; do
	echo "El grupo '$new_primary_group' no existe."
                read -p "Ingrese otro grupo primario: " new_primary_group
        done
	sudo usermod -g "$new_primary_group" "$username"
	echo "El grupo primario ha sido actualizado." ;;
        4)
            gestionar_grupos_secundarios "$username" ;;
        5)
            cambiar_contra "$username" ;;
        9)
            echo "Saliendo del programa."
            ;;
        *)
            echo "Opción inválida. Saliendo del programa."
            ;;
    esac
}
