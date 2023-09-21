#!/bin/bash
source funciones.sh

eliminar_miembros_grupo() {
	read -p "Introduce el nombre del grupo: " group_name
	while ! group_exists $group_name; do
		read -p "El grupo no existe. Introduce otro nombre: " group_name
	done

	read -p "Introduce los nombres de los miembros a eliminar (separados por espacios): " members
	members_not_found=""

	for member in $members; do
		if sudo gpasswd -d $member $group_name >/dev/null 2>&1; then
			echo "Se ha eliminado el miembro '$member' del grupo '$group_name'"
		else
			members_not_found+=" $member"
		fi
	done

	if [ -n "$members_not_found" ]; then
		echo "Los siguientes miembros no se encontraron en el grupo '$group_name':$members_not_found"
	fi
}

