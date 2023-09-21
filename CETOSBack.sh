#!/bin/bash
clear
source centrarHeader.sh
mostrar_menu(){
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
                                    0)
                                        break
                                        ;;
                                    *)
                                        echo "Opción no válida"; sleep 2 ;;
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
                ;;
            3)
                echo "Tres"
                sleep 2
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
                            echo "Opción 4 seleccionada"
                            sleep 2
                            ;;
                        5)
			echo "Realizando copiando usuarios, grupos y contraseñas en DRIVE"
			sleep 2
			rclone copy /var/backups driveResplado:Respaldo-Servidor
			echo "Operacion Terminada"
			sleep 1
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

echo "0 $hora_resp * * * /usr/local/sbin/scriptsV2/backupAutomatico.sh" > cron_config.txt

crontab cron_config.txt

echo "Nueva configuración del cron actulizada para realizar el respaldo a las $hora_resp:00 horas."
sleep 2
				;;
				4)
				echo "Accediento a rclone"
				sleep 1
				clear
				rclone config
				echo "Saliendo a rclone"
				sleep 1
				;;
				0)
                                    echo "Saliendo"
                                    break
                                    ;;
                                *)
                                    echo "opción inválida"
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
