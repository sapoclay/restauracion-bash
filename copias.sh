#!/bin/bash

# Función para realizar la copia de seguridad
backup() {
    read -p "Escribe el nombre de la carpeta que quieres respaldar: " fuente
    read -p "Escribe la ruta completa del directorio destino: " carpeta_destino

    # Verificar si el directorio destino existe, si no, crearlo
    if [ ! -d "$carpeta_destino" ]; then
        echo "Como la carpeta de destino no existe se va a crear"
        mkdir -p "$carpeta_destino"
    fi

    # Obtener la fecha y hora actual en el formato deseado
    fecha_backup=$(date +"%d-%m-%Y-%H-%M-%S")
    archivo_backup="$carpeta_destino/backup-$fecha_backup.tar.gz"

    # Crear archivo tar.gz con la copia de seguridad
    tar -czvf "$archivo_backup" "$fuente"
    
    echo "Copia de seguridad creada en $archivo_backup"
}

# Función para restaurar la copia de seguridad
restaurar() {
    read -p "Escribe la ruta completa del archivo de copia de seguridad a restaurar(backup-DD-MM-YYYY-HH-MM-SS.tar.gz): " archivo_backup
    read -p "Escribe la ubicación donde quieres restaurar la copia de seguridad: " carpeta_restauracion

    # Verificar si el archivo de copia de seguridad existe
    if [ ! -f "$archivo_backup" ]; then
        echo "El archivo de copia de seguridad no existe."
        exit 1
    fi

    # Verificar si la ubicación de restauración existe, si no, crearla
    if [ ! -d "$carpeta_restauracion" ]; then
        mkdir -p "$carpeta_restauracion"
    fi

    # Extraer la copia de seguridad en la ubicación de restauración
    tar -xzvf "$archivo_backup" -C "$carpeta_restauracion"
    
    echo "Copia de seguridad restaurada en $carpeta_restauracion"
}

# Menú de opciones
echo "Menú:"
echo "1. Crear copia de seguridad"
echo "2. Restaurar copia de seguridad"
echo "3. Salir"

read -p "Selecciona una opción (1/2/3): " opcion

case $opcion in
    1)
        backup
        ;;
    2)
        restaurar
        ;;
    3)
        echo "Saliendo del script."
        ;;
    *)
        echo "Opción inválida."
        ;;
esac
