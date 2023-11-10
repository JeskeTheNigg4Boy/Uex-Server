#!/bin/bash
verificar_usuario() {
        if id "$1" >/dev/null 2>&1; then
                return 0
        else
                return 1
        fi
}
verificar_grupo(){
        if getent group "$1" >/dev/null 2>&1; then
                return 0
        else
                return 1
        fi
}
verificar_carpeta_inicio() {
        local home_directory="$1"
        if [ -d "/home/$home_directory" ]; then
                return 0
        else
                return 1
        fi
}
gestionar_grupos_secundarios() {
    local usuario="$1"
    local opcion=""
    echo "¿Qué desea hacer con los grupos secundarios?"
    echo "1) Añadir grupos secundarios"
    echo "2) Quitar grupos secundarios"
    echo "3) Salir"

    read -rp "Ingrese la opción deseada: " opcion
    case "$opcion" in
        1)
            read -rp "Ingrese el grupo: " grupo_secundario
	sudo usermod -aG "$grupo_secundario" "$usuario"
echo "Se han añadido los grupos secundarios al usuario $usuario."
            ;;
        2)
                read -rp "Ingrese los grupos secundarios separados por espacios: " grupos_secundarios
            for grupo in $grupos_secundarios; do
                sudo deluser "$usuario" "$grupo"
            done
            echo "Se han quitado los grupos secundarios del usuario $usuario."
            ;;
        3)
            echo "Saliendo del programa."
            return
            ;;
        *)
            echo "Opción inválida. No se han realizado cambios en los grupos secundarios del usuario $usuario."
            ;;
    esac
}




group_exists() {
        local group_name=$1
        if grep -q "^$group_name:" /etc/group; then
                return 0
        else
                return 1
        fi
}

folder_exists() {
        local folder_name=$1
        if [ -d "/home/$folder_name" ]; then
                return 0
        else
                return 1
        fi
}

user_exists() {
        local username=$1
        if id -u $username >/dev/null 2>&1; then
                return 0
        else
                return 1
        fi
}

valid_permissions() {
        local permissions=$1
        if [[ "$permissions" =~ ^[0-7]{3}$ ]]; then
                return 0
        else
                return 1
        fi
}
folder_exists() {
        local folder_name=$1
        if [ -d "/home/$folder_name" ]; then
                return 0
        else
                return 1
        fi
}

ping_swap() {
    IPTABLES_FILE="/ruta/al/archivo/iptables.conf"

    if grep -qE "^-A INPUT -p icmp -j ACCEPT" "$IPTABLES_FILE"; then
        sed -i 's/^-A INPUT -p icmp -j ACCEPT/#-A INPUT -p icmp -j ACCEPT/' "$IPTABLES_FILE"
        echo "La regla de habilitar ping se ha deshabilitado."
    else
        sed -i 's/#-A INPUT -p icmp -j ACCEPT/-A INPUT -p icmp -j ACCEPT/' "$IPTABLES_FILE"
        echo "La regla de habilitar ping se ha habilitado."
    fi
}
verificar_montaje() {
    if mountpoint -q /var/mysql; then
        nombre_disco=$(df -h /var/mysql | awk 'NR==2 {print $1}' | awk -F/ '{print $3}')
        echo "El disco "$nombre_disco" esta montado en /var/mysql."
    else
        echo "El disco no esta montado en /var/mysql."
    fi
}
