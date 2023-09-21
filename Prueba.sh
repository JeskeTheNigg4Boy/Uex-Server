#!/bin/bash
inicio=1
final=254

guardar_ips="ipValidas.txt"
>$guardar_ips


pings(){
 	ip="192.168.1.$1"
if ping -c 1 -W 1 $ip > /dev/null 2>&1; then
echo "Ip: $ip disponible" >> $guardar_ips
fi
}
for ((ip=inicio; ip<=final; ip++))
do
pings $ip &
done

wait

echo "Escaneo finalizado, datos almacenados en $guardar_ips"
sleep 1
cat "$guardar_ips"
