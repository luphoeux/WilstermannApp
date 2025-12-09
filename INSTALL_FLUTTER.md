# 📱 Guía de Instalación de Flutter para Club Wilstermann App

## Paso 1: Descargar Flutter SDK

1. **Descarga Flutter SDK** desde el sitio oficial:
   - Visita: https://docs.flutter.dev/get-started/install/windows
   - O descarga directamente: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip

2. **Extrae el archivo ZIP**:
   - Crea una carpeta en `C:\src\flutter` (o donde prefieras, pero evita carpetas con espacios o caracteres especiales)
   - Extrae el contenido del ZIP en esa carpeta

## Paso 2: Configurar Variables de Entorno

1. **Abre las Variables de Entorno**:
   - Presiona `Windows + R`
   - Escribe `sysdm.cpl` y presiona Enter
   - Ve a la pestaña "Opciones avanzadas"
   - Haz clic en "Variables de entorno"

2. **Agrega Flutter al PATH**:
   - En "Variables del sistema", busca la variable `Path`
   - Haz clic en "Editar"
   - Haz clic en "Nuevo"
   - Agrega: `C:\src\flutter\bin` (o la ruta donde instalaste Flutter)
   - Haz clic en "Aceptar" en todas las ventanas

## Paso 3: Verificar la Instalación

Abre una **nueva** ventana de PowerShell (importante: debe ser nueva para que cargue las variables de entorno) y ejecuta:

```powershell
flutter --version
flutter doctor
```

## Paso 4: Instalar Dependencias Adicionales

Flutter Doctor te mostrará qué falta instalar. Típicamente necesitarás:

### Android Studio (para desarrollo Android)
1. Descarga desde: https://developer.android.com/studio
2. Instala Android Studio
3. Abre Android Studio y completa la configuración inicial
4. Instala Android SDK (se hace automáticamente en la primera ejecución)

### Visual Studio (para desarrollo Windows)
1. Descarga Visual Studio Community: https://visualstudio.microsoft.com/downloads/
2. Durante la instalación, selecciona "Desarrollo para el escritorio con C++"

### Chrome (para desarrollo Web)
- Si no lo tienes, descarga Chrome desde: https://www.google.com/chrome/

## Paso 5: Configurar Android Studio para Flutter

1. Abre Android Studio
2. Ve a `File > Settings > Plugins`
3. Busca e instala los plugins:
   - Flutter
   - Dart

## Paso 6: Aceptar Licencias de Android

En PowerShell, ejecuta:

```powershell
flutter doctor --android-licenses
```

Acepta todas las licencias presionando `y` cuando se te solicite.

## Paso 7: Verificar que Todo Esté Listo

Ejecuta nuevamente:

```powershell
flutter doctor -v
```

Deberías ver checkmarks (✓) en la mayoría de las opciones.

## 🚀 Crear la App de Club Wilstermann

Una vez que Flutter esté instalado correctamente, ejecuta en este directorio:

```powershell
flutter create --org com.clubwilstermann wilstermann_app
cd wilstermann_app
flutter run
```

---

## ⚡ Comandos Rápidos de Flutter

```powershell
# Ver versión de Flutter
flutter --version

# Verificar instalación
flutter doctor

# Crear nuevo proyecto
flutter create nombre_proyecto

# Ejecutar app
flutter run

# Listar dispositivos conectados
flutter devices

# Limpiar build
flutter clean

# Obtener dependencias
flutter pub get

# Actualizar Flutter
flutter upgrade
```

## 📝 Notas Importantes

- **Reinicia tu terminal** después de agregar Flutter al PATH
- Si usas VS Code, instala las extensiones de Flutter y Dart
- Para desarrollo Android, necesitas un emulador o dispositivo físico conectado
- Para desarrollo iOS, necesitas una Mac con Xcode (no disponible en Windows)

## 🆘 Solución de Problemas Comunes

### "flutter no se reconoce como comando"
- Verifica que agregaste Flutter al PATH correctamente
- Reinicia tu terminal/PowerShell
- Verifica la ruta con: `echo $env:PATH`

### "Android licenses not accepted"
- Ejecuta: `flutter doctor --android-licenses`
- Acepta todas las licencias

### "No devices found"
- Inicia un emulador de Android desde Android Studio
- O conecta un dispositivo físico con USB debugging habilitado

---

**¿Listo para comenzar?** Una vez completados estos pasos, estaremos listos para desarrollar la app de Club Wilstermann! 🔴⚪🔵
