#/bin/bash
source funciones.sh

cambiar_nombre_carpeta() {
    while true; do
        read -p "Ingrese el nombre del grupo: " nombre_grupo

        if verificar_grupo "$nombre_grupo"; then
            break
        else
            echo "El grupo '$nombre_grupo' no existe. Por favor, ingrese otro nombre de grupo."
        fi
    done

    while true; do
        read -p "Ingrese el nuevo nombre de la carpeta: " nuevo_nombre

        if [ -n "$nuevo_nombre" ]; then
            carpeta_grupo="/home/$nuevo_nombre"

            if [ -d "$carpeta_grupo" ]; then
                actual_grupo=$(stat -c '%G' "$carpeta_grupo")
                if [ -z "$actual_grupo" ]; then
                    chown :"$nombre_grupo" "$carpeta_grupo"
                    if [ $? -eq 0 ]; then
                        echo "La carpeta '$nuevo_nombre' se ha asignado al grupo '$nombre_grupo'."
                        break
                    else
                        echo "Hubo un error al asignar la carpeta al grupo."
                    fi
                else
                    echo "La carpeta con el nombre '$nuevo_nombre' ya existe y tiene un grupo propietario ('$actual_grupo')."
                fi
            else
                mkdir "$carpeta_grupo"
                if [ $? -eq 0 ]; then
                    chown :"$nombre_grupo" "$carpeta_grupo"
                    echo "La carpeta '$nuevo_nombre' se ha creado y asignado al grupo '$nombre_grupo' exitosamente."
                    break
                else
                    echo "Hubo un error al crear la carpeta o asignarla al grupo."
                fi
            fi
        else
            echo "El nombre ingresado no es válido. Por favor, ingrese un nuevo nombre de carpeta."
        fi
    done
}
