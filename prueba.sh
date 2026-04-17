# RETO A: IDENTIFICACION DE PATRONES 

# 2.Este script busca patrones de intentos fallidos de acceso en el archivo de logs de autenticación.
sudo grep "Failed password" /var/log/auth.log | tail -n 20

# 3. Creamos el script para verificar intruso y abrimos el editor de texto para crear el script
mkdir -p ~/scripts
nano ~/scripts/check_intruders.sh

# 3.1 Abrimos el editor de texto para crear el script
    #!/bin/bash
    # Definimos las rutas
LOG_FILE="/var/log/auth.log"
OUTPUT_FILE="$HOME/alertas.txt"

echo "--- INFORME DE SEGURIDAD - $(date) ---" > $OUTPUT_FILE
echo "Detectando intentos fallidos de acceso..." >> $OUTPUT_FILE

    # 1. Filtramos fallos
    # 2. Extrae la IP (suele ser la antepenúltima palabra)
    # 3. Contamos ocurrencias únicas
    sudo grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr >> $OUTPUT_FILE
    echo "Informe generado con éxito en $OUTPUT_FILE"

    # 4. Guardamos el script y le damos permisos de ejecución
    chmod +x ~/scripts/check_intruders.sh

# 4. Ejecutamos el shell
./scripts/check_intruders.sh
    # Mostramos el contenido del archivo de alertas
    cat ~/alertas.txt