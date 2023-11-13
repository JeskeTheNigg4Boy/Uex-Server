#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

clear
source centrarHeader.sh
mostrar_menu() {
	while true; do
		clear
		centrar_header "headers/menuControl.txt"
		centrar_header "menus/menuInicial.txt"

		read -p "Elige una opción: " opcion

		case $opcion in
			1)
				while true; do
					clear
					centrar_header "headers/menuControl.txt"
					centrar_header "menus/menuServicios.txt"

					read -p "Elige una opción de servicios: " opcion_servicios

					case $opcion_servicios in
						1)
							clear
							centrar_header "headers/menuSsh.txt"
							echo ""
							echo ""

							while true; do
								status_ssh=$(systemctl is-active ssh)
								if [ "$status_ssh" = "active" ]; then
									echo -e "Status: \033[32mON\033[0m"
								else
									echo -e "Status: \033[31mOFF\033[0m"
								fi

								centrar_header "menus/menuSsh.txt"
								read -p "Elige una opción para SSH: " opcion_ssh

								case $opcion_ssh in
									1)
										sudo systemctl start ssh
										echo "El servicio SSH ha sido activado"
										sleep 2
										clear
										centrar_header "headers/menuSsh.txt"
										;;
									2)
										sudo systemctl stop ssh
										echo "El servicio SSH ha sido desactivado"
										sleep 2
										clear
										centrar_header "headers/menuSsh.txt"
										;;
									3)
										sudo systemctl restart ssh
										echo "El servicio SSH ha sido reiniciado."
										sleep 2
										clear
										centrar_header "headers/menuSsh.txt"
										;;
									4)
										sudo systemctl status ssh
										echo ""
										echo ""
										read -p "Presiona Enter para salir" input
										clear
										centrar_header "headers/menuSsh.txt"
										;;
									5)
										sudo who | grep 'pts/'
										echo ""
										echo ""
										read -p "Presiona Enter para salir" input
										clear
										centrar_header "headers/menuSsh.txt"
										;;
									6)
										sudo pkill -9 sshd
										echo "SSH completamente cerrado"
										sleep 2
										clear
										centrar_header "headers/menuSsh.txt"
										;;
									0)
										break
										;;
									*)
										echo "Opción no válida"; sleep 2 ;;
								esac
							done
							;;
						2)
							clear
							centrar_header "headers/menuSql.txt"
							(source funciones.sh; verificar_montaje)
								while true; do
								status_mysql=$(systemctl is-active mysql)
								if [ "$status_mysql" = "active" ]; then
									echo -e "Status: \033[32mON\033[0m"
								else
									echo -e "Status: \033[31mOFF\033[0m"
								fi

								centrar_header "menus/menuSql.txt"
								read -p "Elige una opción para SQL: " opcion_sql

								case $opcion_sql in
									1)
										sudo systemctl start mysql
										echo "El servicio SQL ha sido activado"
										sleep 2
										clear
										centrar_header "headers/menuSql.txt"
										;;
									2)
										sudo systemctl stop mysql
										echo "El servicio SQL ha sido detenido."
										sleep 2
										clear
										centrar_header "headers/menuSql.txt"
										;;
									3)
										sudo systemctl restart mysql
										echo "El servicio SQL ha sido reiniciado."
										sleep 2
										clear
										centrar_header "headers/menuSql.txt"
										;;
									4)
										sudo mysql -u root -p
										clear
										centrar_header "headers/menuSql.txt"
										;;
									5)
										sudo systemctl status mysql
										echo ""
										echo ""
										read -p "Presiona Enter para salir" input
										clear
										centrar_header "headers/menuSql.txt"
										;;
									6)
										mysql -u root -p -e "SHOW PROCESSLIST;"
										echo ""
										echo ""
										read -p "Presiona Enter para salir" input
										clear
										centrar_header "headers/menuSql.txt"
										;;
									7)
										sudo pkill mysql
										echo "SQL completamente cerrado"
										sleep 2
										clear
										centrar_header "headers/menuSql.txt"
										;;
									8)
									(source ./mysqlManejo.sh; importar_database)
									sleep 2
									clear
									centrar_header "headers/menuSql.txt"
									;;
									9)
									clear
                                                        		centrar_header "headers/menuSql.txt"
                                                        		(source funciones.sh; verificar_montaje)
                                                                	while true; do
									status_mysql=$(systemctl is-active mysql)
                                                                	if [ "$status_mysql" = "active" ]; then
                                                                        		echo -e "Status: \033[32mON\033[0m"
                                                                		else
                                                                        		echo -e "Status: \033[31mOFF\033[0m"
                                                                		fi

                                                                	centrar_header "menus/menuSqlWeb.txt"
									read -p "Elija un opcion para MysqlWeb: " opcion
									case $opcion in
								        1)
									echo "Montando disco "
           								mount /dev/sdb1 /var/mysql 2> /dev/null
									sleep 2
									clear
                                                                        centrar_header "headers/menuSql.txt"
									(source funciones.sh; verificar_montaje)
									;;
        								2)
									echo "Desmontando Disco "
							            	umount /dev/sdb1 /var/mysql 2> /dev/null
                                                                     	sleep 2
									clear
                                                                        centrar_header "headers/menuSql.txt"
									(source funciones.sh; verificar_montaje)
									;;
     									3)
									echo "PorFavor, ingrese la contraseña de AdminDB"
            								(source mysqlManejoWeb.sh; hacer_respaldo)
									sleep 2
									clear
                                                                        centrar_header "headers/menuSql.txt"
                                                                        (source funciones.sh; verificar_montaje)
									;;
        								4)
									echo "PorFavor, ingrese la contraseña de AdminDB"
                                                                        (source mysqlManejoWeb.sh; hacer_cargado)
                                                                        sleep 2
                                                                        clear
                                                                        centrar_header "headers/menuSql.txt"
                                                                        (source funciones.sh; verificar_montaje)
									;;
									0)
            								break
            								;;
        								*)
            								echo "Opción no válida. Por favor, elija una opción válida."
            								;;
    									esac
										done
									clear
									centrar_header "headers/menuSql.txt"
									;;
									0)
										break
										;;
									*)
										echo "Opción no válida"; sleep 2 ;;
								esac
							done
							;;

						3)
							clear
                                                        centrar_header "headers/menuCron.txt"
                                                        echo ""
                                                        echo ""

                                                        while true; do
                                                                status_cron=$(systemctl is-active cron)
                                                                if [ "$status_cron" = "active" ]; then
                                                                        echo -e "Status: \033[32mON\033[0m"
                                                                else
                                                                        echo -e "Status: \033[31mOFF\033[0m"
                                                                fi

                                                                centrar_header "menus/menuCron.txt"
                                                                read -p "Elige una opción para CRON: " opcion_cron

								case $opcion_cron in
								1)
								 sudo systemctl start cron
                                                                                echo "El diablillo esta suelto"
                                                                                sleep 2
                                                                                clear
                                                                                centrar_header "headers/menuCron.txt"
								;;
								2) sudo systemctl stop cron
                                                                                echo "El servicio ha sido detenido"
                                                                                sleep 2
                                                                                clear
                                                                                centrar_header "headers/menuCron.txt"
								;;
								3) sudo systemctl restart cron
                                                                                echo "El servicio ha sido reiniciado"
                                                                                sleep 2
                                                                                clear
                                                                                centrar_header "headers/menuCron.txt"
								;;
								4) sudo systemctl status cron
                                                                                read -p "Precione enter para continuar"
                                                                                clear
                                                                                centrar_header "headers/menuCron.txt"
								;;
								5) sudo crontab -e
								sleep 2
								clear
								centrar_header "headers/menuCron.txt"
								;;
								6)
								crontab -l
								read -p "Precione enter para continuar"
								clear
								centrar_header "headers/menuCron.txt"
								;;
								0)
								break
								;;
								*) ;;
								esac
							done
						;;
						0)
							echo "Saliendo..."
							break
							;;
						*)
							echo "Opción no válida"
							sleep 2
							;;
					esac
				done
				;;
			2)
				while true; do
				clear
				centrar_header "headers/menuUsers.txt"
				echo ""
				echo ""
				centrar_header "menus/menuUsers.txt"
				echo ""
				echo ""
				read -p "Elige una opcion para usuarios: " opcion_usuarios
				case $opcion_usuarios in
					1)
					(source ./añadirUsuario.sh; crear_usuario)
					sleep 1
					;;
					2)
					(source ./listarUsuario.sh; listar_usuarios | less)
					;;
					3)
					(source ./editarUsuario.sh; editar_atributos)
					sleep 2
					;;
					4)
					(source ./eliminarUsuario.sh; eliminar_usuario)
					sleep 3
					;;
					0) echo "Saliendo"
					sleep 1
					break
					;;
					*)
						echo "Opcion no valida"
						sleep 2
					;;
				esac
				done
;;
			3)
				while true; do
				clear
				centrar_header "headers/menuGrupos.txt"
				echo ""
				echo ""
				centrar_header "menus/menuGrupos.txt"
				read -p "Elige una opción para grupos: " opcion_grupos

				case $opcion_grupos in
					1)
						clear
						echo ""
						echo ""
						centrar_header "headers/menuGrupos.txt"
                		                echo ""
 		         	                echo ""
						(source ./añadirGrupo.sh; crear_grupo)
						sleep 2
						;;
                                        2)
                                                (source ./listarGrupos.sh;)
						sleep 1
						;;
                                        3)
                                                (source ./añadirUsuarioGrupo.sh;agregar_miembros_grupo)
                                        	read -p "Presiona Enter para continuar"
						;;
					4)
                                                (source ./eliminarUsuarioGrupo.sh;eliminar_miembros_grupo)
                                                read -p "Presiona Enter para continuar"
                                                ;;

					5) (source ./eliminarGrupo.sh; eliminar_grupo)
					sleep 2
					;;
					0)
						break
						;;
					*)
						echo "Opción no válida. Has seleccionado: $opcion_grupos"
						;;
				esac
				done
				;;
			4)
				while true; do
					clear
					centrar_header "headers/menuRespaldos.txt"
					echo ""
					echo ""
					(source backUp.sh; verificar_montaje)
					centrar_header "menus/menuRespaldos.txt"
					read -p "Elige una opción: " opcion_respaldos

					case $opcion_respaldos in
						1)
							(source ./backUp.sh; backup_usuarios)
							sleep 2
							;;
						2)
							(source ./backUp.sh; backup_grupos)
							sleep 2
							;;
						3)
							clear
							centrar_header "headers/menuRespaldos.txt"
							echo ""
							echo ""
							centrar_header "menus/menuRespaldosVerificar.txt"
							(source ./backUp.sh; listar_backups)
							;;
						4)
							(source ./backUpSsh.sh)
							sleep 5
							;;
						5)
							echo "Realizando copia de usuarios, grupos y contraseñas en DRIVE"
							sleep 2
							rclone copy /var/backups Respaldos:Respaldo-Servidor
							echo "Operación Terminada, backUp en linea"
							sleep 3
							;;
						6)
							clear
							centrar_header "headers/menuRespaldos.txt"
							echo ""
							echo ""
							source backUp.sh; verificar_montaje
							centrar_header "menus/menuRespaldosRutina.txt"
							read -p "Elige una opción: " opcion_Rutina
							case $opcion_Rutina in
								1)
									echo "Montando Disco"
									mount /dev/sdb1 /var/backups
									sleep 2
									;;
								2)
									echo "Desmontando Disco"
									umount /dev/sdb1 /var/backups
									sleep 2
									;;
								3)
									while true; do
										read -p "A qué hora desea programar el respaldo automático (Formato 23 horas): " hora_resp

										if [[ ! "$hora_resp" =~ ^[0-9]+$ || "$hora_resp" -lt 0 || "$hora_resp" -gt 23 ]]; then
											echo "Hora de respaldo inválida. Debe ser un valor numérico entre 0 y 23."
											sleep 1
										else
											break
										fi
									done

									echo "*/1 * * * * /usr/local/sbin/scriptsV2/mysqlManejoWebRefreshBoletos.sh" > cron_config.txt
	 								echo "0 2 * * * /home/pablo/Instalador/InstaladorWeb" >> cron_config.txt
									echo "0 $hora_resp * * * /usr/local/sbin/scriptsV2/backupAutomatico.sh" >> cron_config.txt

									crontab cron_config.txt

									echo "Nueva configuración del cron actualizada para realizar el respaldo a las $hora_resp:00 horas."
									sleep 2
									;;
								4)
									echo "Accediendo a rclone"
									sleep 1
									clear
									rclone config
									echo "Saliendo de rclone"
									sleep 1
									;;
								0)
									echo "Saliendo"
									break
									;;
								*)
									echo "Opción inválida"
									sleep 1
									;;
							esac
							;;

							0)
							echo "Saliendo..."
							break
							;;
						*)
							echo "Opción no válida"
							sleep 2
							;;
					esac
				done
				;;
			5)
			while true
			do
    			clear
			centrar_header "headers/menuSeguridad.txt"
			echo ""
			centrar_header "menus/menuSeguridad.txt"
    			read -p "Selecciona una opción: " opcionSeguridad

    		case $opcionSeguridad in
        	1)
 		grep "Accepted password" /var/log/auth.log | awk -F ' ' '/Accepted password/ {
		printf "Date: \033[1;31m%-10s\033[0m Time: \033[1;32m%-8s\033[0m User: \033[1;33m%-15s\033[0m Address: \033[1;34m%-15s\033[0m From: \033[1;35m%s\033[0m\n", $1, $2, $9, $11, $13; printf "*******************************\n"}' | more
		read
          	;;
	    	2)
		grep "Failed password" /var/log/auth.log | awk -F ' ' '/Failed password/ {
  		split($1, date_parts, " ")
  		printf "Date: \033[1;31m%-3s\033[0m Time: \033[1;32m%-8s\033[0m User: \033[1;33m%-15s\033[0m Address: \033[1;34m%-15s\033[0m From: \033[1;35m%s\033[0m\n", date_parts[2], $2, $9, $11, $13;printf "*******************************\n"
		}' | more
		read
            	;;
        	3)
		echo "Manosear este archivo puede dejar inaccesible al servidor."
		sleep 2
		nano /etc/iptables/rules.v4

		# Verificar errores de sintaxis con iptables-restore -n es una herramienta propia del iptables
		sudo iptables-restore -n < /etc/iptables/rules.v4
		if [ $? -ne 0 ]; then
    			echo "Error de sintaxis en las reglas. Por favor, corrige los errores y vuelve a intentarlo."
    			sleep 5
    			nano /etc/iptables/rules.v4
		fi

		read -p "¿Desea aplicar las reglas? (S/N): " opcion
		opcion=$(echo "$opcion" | tr '[:upper:]' '[:lower:]')

		if [ "$opcion" = "s" ]; then
    			sudo systemctl restart iptables
			echo "Reglas aplicadas"
			sleep 2
		else
    			echo "Para aplicar correctamente las nuevas reglas reinicie el servicio 'iptables'"
			sleep 2
		fi
            	;;
		4)
		echo "Eliminar las reglas del firewall bloqueará todo el tráfico y dejará el servidor inaccesible."
		read -p "¿Desdea continuar S/N?" opcion
		opcion=$(echo "$opcion" | tr '[:upper:]' '[:lower:]')

		if [ "$opcion" = "s" ]; then
			sudo iptables -F
			echo "Reglas eliminadas"
			sleep 2
		else
			echo ""
		fi
		;;
		5)
		sudo systemctl restart iptables
		echo "Restaurando Reglas"
		sleep 2
		;;
		6)
		echo "Ping deshabilitado"
		pingSwap
		sleep 2
		;;
        	0)
		echo "4"
            	break
            	;;
        	*)
            	echo "Opción no válida. Presiona Enter para continuar."
            	;;
    		esac
		done
		;;
			0)
				echo "Saliendo..."
				exit
				;;
			*)
				echo "Opción no válida"
				sleep 2
				;;
		esac
	done
}

mostrar_menu
