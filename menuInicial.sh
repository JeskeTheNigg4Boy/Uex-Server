#!/bin/bash
source centrarHeader.sh
mostrar_submenu() {
    clear
    centrar_header "headers/menuUsuarios.txt"

    echo
    echo
    echo "  1 Añadir usuarios"
    echo "  2 Listar usuarios"
    echo "  3 Modificar usuario"
    echo "  4 Eliminar usuario"
    echo -e "\033[31m  9 Volver\033[0m"
}

mostrar_submenu2() {
	clear
	centrar_header "headers/menuGrupos.txt"

	echo
	echo
	echo "	1 Añadir grupo"
	echo "	2 Listar grupo"
	echo "	3 Añadir Usuario"
	echo "	4 Eliminar Usuario"
	echo "	5 Cambiar carpeta Grupo"
	echo "	6 Eliminar grupo"
	echo -e "\033[31m9 Volver\033[0m"
}

mostrar_menu() {
	clear
	opcion=0
	while [ $opcion -ne 9 ]; do
	centrar_header "headers/menuIncial.txt"
	echo
	echo
	echo "  1 Usuarios"
	echo "  2 Grupos"
	echo -e "\033[31m  9 Salir\033[0m"
	read -p "   Seleccione una opción: " opcion

	case $opcion in
		1)
                submenu_opcion=0
                while [ $submenu_opcion -ne 9 ]; do
                    mostrar_submenu
                    read -p "     Seleccione una opción: " submenu_opcion
                    case $submenu_opcion in
                        1)
                            (source ./añadirUsuario.sh; crear_usuario)
                            sleep 1
                            ;;
                        2)
                            (source ./listarUsuario.sh; listar_usuarios | less)
                            ;;
                        3)
                            (source ./editarUsuario.sh; editar_atributos)
			sleep 1
		        ;;
                        4)
                            (source ./eliminarUsuario.sh; eliminar_usuario)
                           sleep 1 
			;;
                        9)
                            echo "    Volviendo al menú principal..."
                            sleep 1
                            clear
                            ;;
                        *)
                            echo "Opción inválida"
                            ;;
                    esac
                done
                ;;
            2)
                submenu_opcion2=0
                while [ $submenu_opcion2 -ne 9 ]; do
                    mostrar_submenu2
                    read -p "     Seleccione una opción: " submenu_opcion2
                    case $submenu_opcion2 in
                        1)
			 (source ./añadirGrupo.sh; crear_grupo)
			sleep 1 ;;
			2)
			(source ./listarGrupos.sh;);;
			3)
			(source ./añadirUsuarioGrupo.sh; agregar_miembros_grupo)
			;;
			4)
			(source ./eliminarUsuarioGrupo.sh; eliminar_miembros_grupo);;
			5)(source ./cambiarNombre.sh; cambiar_nombre_carpeta)
			;;
			6)
                      (source ./eliminarGrupo.sh; eliminar_grupo)
                        sleep 1;;
			
			9)
                            echo "    Volviendo al menú principal..."
                            sleep 1
                            clear

			;;
                        *)
                            echo "Opción inválida"
                            ;;
                    esac
                done
                ;;

	9)

                echo "Saliendo del programa..."
		;;
            *)
                echo "Opción inválida"
                ;;
        esac
    done
}

mostrar_menu
