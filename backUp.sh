#!/bin/bash

backup_usuarios() {
	ruta_destino_back="/var/backups/"
	ruta_destino_user="/var/backups/uex-user/user"
	ruta_destino_pass="/var/backups/uex-user/pass"
	hora_actual=$(date +"%Y-%m-%d_%H-%M-%S")

	cp /etc/passwd "$ruta_destino_user/passwd_backup_$hora_actual"
	cp /etc/shadow "$ruta_destino_pass/shadow_backup_$hora_actual"
	echo "Copiando archivos"
	sleep 1

	chmod 600 "$ruta_destino_user/passwd_backup_$hora_actual"
	chmod 600 "$ruta_destino_pass/shadow_backup_$hora_actual"
	echo "Cambiando permisos"	
sleep 1
	echo "Backups de usuarios creados exitosamente en $ruta_destino_back"
	sleep 2
}

backup_grupos(){
	rute_destino_back="/var/backups/"
	ruta_destino="/var/backups/uex-user/group"
	hora_actual=$(date +"%Y-%m-%d_%H-%M-½S")
	cp /etc/group "$ruta_destino/group_backup_$hora_actual"
	echo "Copiando archivo"
	sleep 1
	chmod 600 "$ruta_destino/group_backup_$hora_actual"
	echo "Cambiando permiso"
	sleep 1
	echo "Backup de grupos creado exitosamente en $ruta_destino"


}

listar_backups() {
    ruta_base="/var/backups/uex-user/"

    read -p "Ingrese la opcion deseada: " opcion

    case $opcion in
        1)
            carpeta="user"
            ;;
        2)
            carpeta="pass"
            ;;
        3)
            carpeta="group"
            ;;
        *)
            echo "Opcion Invalida."
            break
        sleep 1
            ;;
    esac

    ruta_backups="$ruta_base/$carpeta"
        clear
        sleep 1
         echo "Archivos de backups en la carpeta $ruta_backups:"
    ls -l "$ruta_backups" | less
}

verificar_montaje() {
    if mountpoint -q /var/backups; then
        nombre_disco=$(df -h /var/backups | awk 'NR==2 {print $1}' | awk -F/ '{print $3}')
        echo "El disco "$nombre_disco" esta montado en /var/backups."
    else
        echo "El disco no esta montado en /var/backups."
    fi
}

