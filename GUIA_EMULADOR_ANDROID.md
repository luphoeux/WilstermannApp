# 📱 Guía: Ejecutar la App en Emulador Android

## 🎯 Objetivo
Ejecutar la aplicación Club Wilstermann en un emulador Android virtual usando Android Studio.

---

## ✅ Paso 1: Verificar/Instalar Android Studio

### Verificar si Android Studio está instalado:

1. **Buscar Android Studio en tu PC:**
   - Presiona `Win + S`
   - Busca "Android Studio"
   - Si aparece, anota la ruta de instalación

2. **Si NO está instalado:**
   - Descarga desde: https://developer.android.com/studio
   - Ejecuta el instalador
   - Sigue el asistente de instalación
   - **IMPORTANTE:** Durante la instalación, asegúrate de marcar:
     - ✅ Android SDK
     - ✅ Android SDK Platform
     - ✅ Android Virtual Device (AVD)

---

## ✅ Paso 2: Configurar Android SDK

### Desde Android Studio:

1. Abre **Android Studio**
2. Ve a `File` → `Settings` (o `Ctrl + Alt + S`)
3. Navega a `Appearance & Behavior` → `System Settings` → `Android SDK`
4. En la pestaña **SDK Platforms**, instala:
   - ✅ Android 13.0 (Tiramisu) - API Level 33
   - ✅ Android 12.0 (S) - API Level 31
5. En la pestaña **SDK Tools**, verifica que estén instalados:
   - ✅ Android SDK Build-Tools
   - ✅ Android SDK Command-line Tools
   - ✅ Android Emulator
   - ✅ Android SDK Platform-Tools
6. Haz clic en `Apply` y espera a que se descarguen

---

## ✅ Paso 3: Crear un Emulador Android (AVD)

### Opción A: Desde Android Studio (Recomendado)

1. Abre **Android Studio**
2. En la pantalla de bienvenida, haz clic en `More Actions` → `Virtual Device Manager`
   - O ve a `Tools` → `Device Manager` si tienes un proyecto abierto
3. Haz clic en `Create Device`
4. **Selecciona un dispositivo:**
   - Recomendado: **Pixel 6** o **Pixel 5**
   - Haz clic en `Next`
5. **Selecciona una imagen del sistema:**
   - Recomendado: **Tiramisu (API 33)** o **S (API 31)**
   - Si no está descargada, haz clic en el icono de descarga
   - Haz clic en `Next`
6. **Configuración del AVD:**
   - Nombre: `Pixel_6_API_33` (o el que prefieras)
   - Orientación: Portrait
   - Haz clic en `Show Advanced Settings` (opcional):
     - RAM: 2048 MB (mínimo)
     - Internal Storage: 2048 MB
   - Haz clic en `Finish`

### Opción B: Desde la Línea de Comandos

```powershell
# Listar dispositivos disponibles
C:\Users\<TU_USUARIO>\AppData\Local\Android\Sdk\cmdline-tools\latest\bin\avdmanager.bat list device

# Crear un emulador
C:\Users\<TU_USUARIO>\AppData\Local\Android\Sdk\cmdline-tools\latest\bin\avdmanager.bat create avd -n Pixel_6_API_33 -k "system-images;android-33;google_apis;x86_64" -d pixel_6
```

---

## ✅ Paso 4: Configurar Flutter para usar Android Studio

### Ejecuta estos comandos en PowerShell:

```powershell
# Navega a tu proyecto
cd "d:\Repositorios\Club Wilstermann App 2026"

# Configura la ruta de Android Studio (ajusta según tu instalación)
# Opción 1: Instalación estándar
C:\src\flutter\bin\flutter.bat config --android-studio-dir="C:\Program Files\Android\Android Studio"

# Opción 2: Si está en otra ubicación (ejemplo)
# C:\src\flutter\bin\flutter.bat config --android-studio-dir="C:\Users\<TU_USUARIO>\AppData\Local\Programs\Android Studio"

# Configura el Android SDK
C:\src\flutter\bin\flutter.bat config --android-sdk="C:\Users\<TU_USUARIO>\AppData\Local\Android\Sdk"

# Verifica la configuración
C:\src\flutter\bin\flutter.bat doctor -v
```

---

## ✅ Paso 5: Iniciar el Emulador

### Opción A: Desde Android Studio

1. Abre **Android Studio**
2. Ve a `Tools` → `Device Manager`
3. Encuentra tu emulador en la lista
4. Haz clic en el botón ▶️ (Play) junto al emulador
5. Espera a que el emulador inicie completamente (puede tardar 1-2 minutos la primera vez)

### Opción B: Desde la Línea de Comandos

```powershell
# Listar emuladores disponibles
C:\src\flutter\bin\flutter.bat emulators

# Iniciar un emulador específico
C:\src\flutter\bin\flutter.bat emulators --launch <NOMBRE_DEL_EMULADOR>

# Ejemplo:
C:\src\flutter\bin\flutter.bat emulators --launch Pixel_6_API_33
```

---

## ✅ Paso 6: Ejecutar la App en el Emulador

### Una vez que el emulador esté corriendo:

```powershell
# Navega a tu proyecto
cd "d:\Repositorios\Club Wilstermann App 2026"

# Verifica que Flutter detecte el emulador
C:\src\flutter\bin\flutter.bat devices

# Deberías ver algo como:
# emulator-5554 • sdk gphone64 x86 64 • android-x64 • Android 13 (API 33)

# Ejecuta la app en el emulador
C:\src\flutter\bin\flutter.bat run
```

### Si tienes múltiples dispositivos conectados:

```powershell
# Ejecuta en un dispositivo específico
C:\src\flutter\bin\flutter.bat run -d emulator-5554
```

---

## 🔧 Solución de Problemas Comunes

### Problema 1: "Could not find Android Studio"

**Solución:**
```powershell
# Encuentra dónde está instalado Android Studio
# Busca en estas ubicaciones comunes:
# - C:\Program Files\Android\Android Studio
# - C:\Program Files (x86)\Android\Android Studio
# - C:\Users\<TU_USUARIO>\AppData\Local\Programs\Android Studio

# Configura la ruta correcta
C:\src\flutter\bin\flutter.bat config --android-studio-dir="<RUTA_CORRECTA>"
```

### Problema 2: "Android SDK not found"

**Solución:**
```powershell
# El SDK suele estar en:
# C:\Users\<TU_USUARIO>\AppData\Local\Android\Sdk

# Configúralo:
C:\src\flutter\bin\flutter.bat config --android-sdk="C:\Users\<TU_USUARIO>\AppData\Local\Android\Sdk"
```

### Problema 3: "No emulators available"

**Solución:**
- Abre Android Studio
- Ve a `Tools` → `Device Manager`
- Crea un nuevo emulador (ver Paso 3)

### Problema 4: El emulador es muy lento

**Soluciones:**
1. **Habilitar aceleración de hardware:**
   - Asegúrate de que Intel HAXM esté instalado (Windows)
   - O que Hyper-V esté habilitado (Windows 10/11 Pro)

2. **Ajustar configuración del emulador:**
   - Edita el emulador en Device Manager
   - `Show Advanced Settings`
   - Aumenta RAM a 4096 MB
   - Habilita "Hardware - GLES 2.0"

3. **Usar un emulador más ligero:**
   - Crea un emulador con API 30 o menor
   - Usa una resolución más baja

### Problema 5: "Gradle build failed"

**Solución:**
```powershell
# Limpia el proyecto
cd "d:\Repositorios\Club Wilstermann App 2026"
C:\src\flutter\bin\flutter.bat clean

# Obtén las dependencias nuevamente
C:\src\flutter\bin\flutter.bat pub get

# Intenta ejecutar de nuevo
C:\src\flutter\bin\flutter.bat run
```

---

## 📋 Checklist Rápido

Antes de ejecutar la app, verifica:

- [ ] Android Studio instalado
- [ ] Android SDK instalado (API 31 o superior)
- [ ] Emulador Android creado (AVD)
- [ ] Flutter configurado con Android Studio
- [ ] Emulador iniciado y corriendo
- [ ] `flutter devices` muestra el emulador

---

## 🎯 Comandos Rápidos de Referencia

```powershell
# Ver configuración de Flutter
C:\src\flutter\bin\flutter.bat config

# Ver dispositivos conectados
C:\src\flutter\bin\flutter.bat devices

# Listar emuladores
C:\src\flutter\bin\flutter.bat emulators

# Ejecutar en emulador
C:\src\flutter\bin\flutter.bat run

# Hot reload (mientras la app está corriendo)
# Presiona 'r' en la terminal

# Hot restart (mientras la app está corriendo)
# Presiona 'R' en la terminal

# Detener la app
# Presiona 'q' en la terminal
```

---

## 💡 Consejos

1. **Primera ejecución:** La primera vez que ejecutes la app en Android puede tardar varios minutos en compilar.

2. **Hot Reload:** Una vez que la app esté corriendo, puedes hacer cambios en el código y presionar `r` para ver los cambios instantáneamente.

3. **Rendimiento:** Los emuladores consumen muchos recursos. Cierra otras aplicaciones pesadas mientras lo uses.

4. **Alternativa:** Si tu PC no tiene buenos recursos, considera usar un dispositivo Android físico conectado por USB.

---

## 📱 Usar un Dispositivo Android Físico (Alternativa)

Si prefieres usar tu teléfono Android:

1. **Habilita las Opciones de Desarrollador:**
   - Ve a `Configuración` → `Acerca del teléfono`
   - Toca 7 veces en "Número de compilación"

2. **Habilita la Depuración USB:**
   - Ve a `Configuración` → `Opciones de desarrollador`
   - Activa "Depuración USB"

3. **Conecta el teléfono:**
   - Conecta tu teléfono a la PC con un cable USB
   - Acepta el mensaje de "Permitir depuración USB"

4. **Verifica la conexión:**
   ```powershell
   C:\src\flutter\bin\flutter.bat devices
   ```

5. **Ejecuta la app:**
   ```powershell
   C:\src\flutter\bin\flutter.bat run
   ```

---

**Última actualización:** 2025-12-09
**Versión:** 1.0.0

¡Buena suerte! 🚀
