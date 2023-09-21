#!/bin/bash
source funciones.sh

agregar_miembros_grupo() {
	read -p "Introduce el nombre del grupo: " group_name
	while ! group_exists $group_name; do
		read -p "El grupo no existe. Introduce otro nombre: " group_name
	done

	read -p "Introduce los nombres de los miembros a agregar (separados por espacios): " members

	for member in $members; do
	if getent passwd $member &>/dev/null; then
	sudo gpasswd -a $member $group_name >/dev/null 2>&1
		echo "Se ha agregado el miembro '$member' al grupo '$group_name'"
		else
		echo "El usuario '$member' no existe. No se agregará al grupo '$group_name'."
		fi
	done
}
