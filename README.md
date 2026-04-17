# Bitácora III - Operación Escudo

## Fundamentos de Seguridad y Auditoría

El sistema Syslog es un estándar utilizado en sistemas Linux para la gestión de registros. Clasifica los eventos según dos parámetros: la facilidad, que indica el origen del mensaje (auth, cron, daemon), y la severidad (severity), que indica su nivel de importancia.

Permitir acceso de lectura al archivo `/var/log/auth.log` a usuarios no privilegiados supone un riesgo crítico, ya que contiene información sensible como nombres de usuario, direcciones IP y detalles de intentos de acceso fallidos. Esto puede facilitar ataques de fuerza bruta o ingeniería social.

En un intento fallido de conexión SSH se pueden identificar datos como:

* Dirección IP del atacante
* Puerto de origen
* Usuario utilizado
* Mensaje: "Failed password"

En cambio, un fallo local no suele incluir IP externa.

A nivel empresarial, el Log Management permite centralizar logs en servidores seguros, evitando su manipulación en caso de ataque. Además, cumple con normativas como el RGPD, asegurando la trazabilidad y protección de datos.

## Referencias

[1] Canonical Ltd., "Ubuntu Server documentation," 2025.
[2] M. B. Alonso Alegre Díez, "Gestión de Logs," UNIR, 2016.
