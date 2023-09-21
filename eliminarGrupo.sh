#!/bin/bash
source funciones.sh

eliminar_grupo() {
		read -p "Introduce el nombre del grupo que deseas eliminar: " group_name
	while ! group_exists $group_name; do
		read -p "El grupo no existe. Introduce otro nombre: " group_name
	done

	primary_users=$(grep ":$group_name:" /etc/passwd | cut -d: -f1)
		if [[ -n $primary_users ]]; then
	echo "El grupo '$group_name' es el grupo principal de los siguientes usuarios:"
	echo "$primary_users"
		read -p "¿Deseas reasignar a estos usuarios a otro grupo? (s/n): " reassign_confirmation
        if [[ $reassign_confirmation == "s" || $reassign_confirmation == "S" ]]; then
           	 read -p "Introduce el nombre del nuevo grupo para los usuarios: " new_group_name
            	while ! group_exists $new_group_name; do
                	read -p "El grupo no existe. Introduce otro nombre: " new_group_name
            	done
o
            for user in $primary_users; do
                sudo usermod -g $new_group_name $user
            done
        else
            echo "Operación cancelada. No se han realizado cambios en los usuarios."
            return
        	fi
   	 fi

	read -p "Estás a punto de eliminar el grupo '$group_name' y su carpeta asociada. ¿Estás seguro? (s/n): " confirmation
		if [[ $confirmation == "s" || $confirmation == "S" ]]; then

	sudo groupdel $group_name
	sudo rm -rf "/home/$group_name"
	echo "El grupo '$group_name' y su carpeta asociada han sido eliminados correctamente."
		else
	echo "Operación cancelada. El grupo y la carpeta no han sido eliminados."
    	fi
}

