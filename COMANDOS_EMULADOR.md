# 🎯 Comandos para Ejecutar en Emulador Android

## Una vez que el emulador esté corriendo:

# 1. Detén la app de Chrome (en la terminal donde está corriendo)
# Presiona 'q' en esa terminal

# 2. Verifica que el emulador esté detectado
C:\src\flutter\bin\flutter.bat devices

# 3. Ejecuta la app en el emulador
C:\src\flutter\bin\flutter.bat run

# Si tienes múltiples dispositivos, especifica el emulador:
C:\src\flutter\bin\flutter.bat run -d emulator-5554

# 4. La primera vez tardará varios minutos en compilar
# Sé paciente, es normal

# 5. Una vez que esté corriendo, puedes hacer hot reload:
# Presiona 'r' en la terminal para ver cambios instantáneos
# Presiona 'R' para hot restart completo
# Presiona 'q' para detener la app
