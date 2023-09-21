#!/bin/bash

inicio=1
final=254

guardar_ips="ipValidas.txt"
>$guardar_ips

pings() {
    ip="192.168.1.$1"
    if ping -c 1 -W 1 $ip > /dev/null 2>&1; then
        echo "IP: $ip disponible" >> $guardar_ips
    fi
}

for ((ip=inicio; ip<=final; ip++)); do
    pings $ip &
done

wait

echo "Escaneo finalizado, IPs almacenadas en $guardar_ips"
sleep 1
cat "$guardar_ips"

echo "Por favor, ingrese el nombre de usuario para realizar la copia de seguridad:"
read username

echo "Por favor, ingrese la dirección IP a la que desea realizar la copia de seguridad (por ejemplo, 192.168.1.X):"
read backup_ip

# Validación de dirección IP de respaldo
if [[ ! $backup_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "La dirección IP de respaldo ingresada no es válida."
    exit 1
fi

# Intento de copia de seguridad
echo "Realizando copia de seguridad..."
scp -r /var/backups/uex-user/ "$username@$backup_ip":~/Descargas/

# Comprobar el resultado de la copia de seguridad
if [ $? -eq 0 ]; then
    echo "Copia de seguridad finalizada con éxito."
else
    echo "Error al realizar la copia de seguridad."
fi
