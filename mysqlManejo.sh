#!/bin/bash

function importar_database(){
	if systemctl is-active mysql &> /dev/null; then
   	echo ""
	 else
	echo "MySQL no está activado. Por favor, asegúrate de que el servicio esté en ejecución antes de continuar."
        return 1
    fi
	echo "Archivos en /var/mysql/DBuser:"
    ls /var/mysql/DBuser

    while true; do
        read -p "Ingresa el nombre de la base de datos que deseas crear (o presiona Enter para salir): " nombre_base_datos

        if [ -z "$nombre_base_datos" ]; then
            echo "Saliendo del programa."
            break
        fi

        mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS $nombre_base_datos;"

        read -p "Ingresa el nombre del archivo SQL que deseas importar: " archivo_sql

        if [ -f "/var/mysql/$archivo_sql" ]; then
            mysql -u root -p $nombre_base_datos < "/var/mysql/$archivo_sql"
            echo "Base de datos creada y archivo SQL importado con éxito en la base de datos $nombre_base_datos."
            break
        else
            echo "El archivo SQL '$archivo_sql' no existe en /var/mysql."
        fi
    done
}

#NO TOCAS NO ESTA HABILITADO ÑEÑEÑEÑEÑE
function eliminar_database() {
	if systemctl is-active mysql &> /dev/null; then
        echo "MySQL está activado."
    else
        echo "MySQL no está activado. Por favor, asegúrate de que el servicio esté en ejecución antes de continuar."
        return 1
    fi


	while true; do
        read -p "Ingresa el nombre de la base de datos que deseas eliminar (o presiona Enter para salir): " nombre_base_datos

        if [ -z "$nombre_base_datos" ]; then
            echo "Saliendo del programa."
            break
        fi

        if mysql -u root -p -e "SHOW DATABASES LIKE '$nombre_base_datos';" | grep -q "$nombre_base_datos"; then
            read -p "¿Estás seguro de que deseas eliminar la base de datos '$nombre_base_datos'? (s/n): " confirmacion
            if [ "$confirmacion" = "s" ] || [ "$confirmacion" = "S" ]; then
                mysql -u root -p -e "DROP DATABASE $nombre_base_datos;"
                echo "Base de datos '$nombre_base_datos' eliminada con éxito."
            else
                echo "Operación cancelada."
            fi
        else
            echo "La base de datos '$nombre_base_datos' no existe en MySQL."
        fi
    done
}
importar_database
