#!/bin/bash

centrar_header() {
	ancho_terminal=$(tput cols)
	archivo=$1

while IFS= read -r linea; do
	local espacios=$(( (ancho_terminal - ${#linea}) / 2 ))
	printf "%*s%s\n" $espacios "" "$linea"
	done < $1
}

centrar_header
