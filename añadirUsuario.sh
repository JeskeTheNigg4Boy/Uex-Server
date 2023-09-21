#!/bin/bash
source ./funciones.sh
clear
crear_usuario() {
		read -p "Ingrese nombre de usuario: " username
	while verificar_usuario "$username"; do
		echo "El nombre de usuario '$username' ya está en uso."
		read -p "Ingrese otro nombre de usuario: " username
	done

	read -p "Ingrese contraseña de usuario: " password

	while [[ -z $password ]]; do
        	echo "Ingrese una contraseña porfavor"
        sleep 1
		read -p "Ingrese contraseña para el usuario: " password
	done

	sudo useradd -N -m -g usuarios -s /bin/bash -d "/home/$username" $username
	echo "$username:$password" | sudo chpasswd

	sudo mkdir -p /home/$home_directory
	sudo chown $username:usuarios /home/$home_directory
	sudo chmod 700 /home/$home_directory
	echo "Usuario $username creado exitosamente."
}
