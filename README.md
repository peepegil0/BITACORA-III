# AEE. Bitácora III. Conexiones Empresariales: Operación Escudo

## Descripción del Proyecto
Repositorio con la documentación y scripts del Taller "Operación Escudo". Aquí aplico técnicas de *Hardening*, configuración de cortafuegos (UFW) y vigilancia de logs para proteger un servidor, asumiendo el rol de Administrador de Sistemas.

## Fundamentos de Seguridad y Auditoría

### 1. ¿Cómo se organizan los logs? (Syslog)
Investigando cómo Linux maneja la avalancha de mensajes que genera el sistema, vi que Syslog organiza todo este caos cruzando dos variables súper básicas:
* **Facilidad (Facility):** Básicamente nos dice "quién" o "qué programa" mandó el mensaje. Por ejemplo, te indica si el aviso viene del sistema de contraseñas (`auth`), de una tarea programada (`cron`) o de procesos en segundo plano (`daemon`).
* **Prioridad (Severity):** Nos dice "cómo de grave" es el aviso. Utiliza una escala que va desde simples mensajes informativos para programadores (`debug`) hasta alertas rojas de que el sistema se está cayendo a pedazos (`emerg`).

### 2. El peligro de exponer /var/log/auth.log
Buscando información sobre este archivo en concreto, la conclusión es clara: dejarlo con permisos de lectura para cualquiera es peligroso para ti mismo. Este archivo guarda todos los intentos de inicio de sesión. Si cualquier usuario "invitado" puede leerlo, podría ver los nombres de los administradores y usar esa información para intentar escalar a ususario con mayor permiso.

Además, analizando este archivo te das cuenta de:
* **Si es un fallo local:** Verás que alguien la lio con la contraseña estando físicamente en el ordenador.
* **Si es un ataque remoto (SSH):** Es distinto. El log te da muchos más detalles: te muestra el número de proceso el cual se encuentra justo después del nombre del servicio que generó la entrada, encerrado entre corchetes. El usuario y el atacante que está intentando adivinar y, lo más importante, su **dirección IP**. Con la IP ya puedes saber si te está atacando un *bot* desde otro país para bloquearlo en el cortafuegos.

### 3. Log Management y por qué no dejar los logs en casa
Leyendo artículos sobre gestión empresarial de registros, entendí por qué no se pueden dejar los logs en la misma máquina que los genera. Si un atacante logra entrar en tu servidor, lo primero que va a hacer es borrar los archivos de registro para que nadie sepa cómo entró ni qué hizo. Y se instalaria en tu maquina sin que sepas que esta:

La solución es el *Log Management*: enviar esos registros en tiempo real a un servidor externo seguro. Así, aunque te revienten el servidor principal, el atacante no podrá borrar sus huellas porque ya están a salvo en otro sitio. Además, esto es vital por temas legales en España. Si hay una fuga de datos y nos hacen una auditoría, tener los logs externalizados y protegidos es la única manera de demostrar ante la ley qué ha pasado exactamente y que tenían las medidas de seguridad adecuadas.


