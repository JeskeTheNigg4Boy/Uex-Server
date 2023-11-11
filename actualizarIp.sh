#!/bin/bash

# Obtener la dirección IPv4 del router
ipv4=$(wget -4 -qO- ifconfig.me)

# Configurar el correo electrónico
recipient="viauyrespaldosservidor@gmail.com"
subject="Dirección IPv4 del router"
body="La dirección IPv4 de tu router es: $ipv4"

# Enviar correo electrónico
echo -e "Subject:$subject\n$body" | ssmtp "$recipient"
