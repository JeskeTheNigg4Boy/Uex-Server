#!/bin/bash

backup_total() {
	ruta_destino_back="/var/backups/uex-user"
	ruta_destino_user="$ruta_destino_back/user"
	ruta_destino_pass="$ruta_destino_back/pass"
	ruta_destino_group="$ruta_destino_back/group"

	ruta_destino_back="/var/backups/uex-group"
	ruta_destino_group="$ruta_destino_back/group"

	hora_actual=$(date +"%Y-%m-%d_%H-%M-%S")

	cp /etc/passwd "$ruta_destino_user/passwd_backup_$hora_actual"
	cp /etc/shadow "$ruta_destino_pass/shadow_backup_$hora_actual"
 	cp /etc/group "$ruta_destino_group/group_backup_$hora_actual"

	echo "Copiando archivos"
		sleep 1

	chmod 600 "$ruta_destino_user/passwd_backup_$hora_actual"
	chmod 600 "$ruta_destino_pass/shadow_backup_$hora_actual"
	chmod 600 "$ruta_destino_group/group_backup_$hora_actual"

	echo "Cambiando permisos"
		sleep 1

	echo "Backups de usuarios y grupos creados exitosamente en $ruta_destino_back y $ruta_destino_group"
}
backup_total
