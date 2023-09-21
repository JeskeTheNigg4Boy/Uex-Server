#!/bin/bash
source funciones.sh

crear_grupo() {
		read -p "Introduce un nombre de grupo: " group_name
	while group_exists $group_name; do
 		read -p "El nombre de grupo ya existe. Introduce otro nombre: " group_name
	done

	folder_name=$group_name

		read -p "Introduce un nombre para el dueño del grupo: " owner_name
	while ! user_exists $owner_name; do
		read -p "El usuario no existe. Introduce otro nombre: " owner_name
	done

		read -p "Introduce los permisos (en formato de tres números): " permissions
 	while ! valid_permissions $permissions; do
        	read -p "Permisos inválidos. Introduce los permisos nuevamente: " permissions
	done

	sudo groupadd $group_name
	sudo mkdir "/home/$folder_name"

	sudo chmod $permissions "/home/$folder_name"

	sudo chown $owner_name:$group_name "/home/$folder_name"

	echo "Grupo creado exitosamene."
}

