# 🚀 Ejecutar en Android - Guía Rápida

## Paso 1: Iniciar el Emulador

### Desde Android Studio:
1. Abre Android Studio
2. Tools → Device Manager
3. Clic en ▶️ junto a tu emulador
4. Espera 1-2 minutos

### Desde Línea de Comandos:
```powershell
# Listar emuladores disponibles
C:\src\flutter\bin\flutter.bat emulators

# Iniciar emulador (reemplaza NOMBRE con el de tu emulador)
C:\src\flutter\bin\flutter.bat emulators --launch NOMBRE
```

---

## Paso 2: Verificar que Flutter Detecte el Emulador

```powershell
C:\src\flutter\bin\flutter.bat devices
```

Deberías ver algo como:
```
SM S918B (mobile) • adb-R5CW12XQ95Y... • android-x64 • Android 13 (API 36)
```

---

## Paso 3: Detener la App de Chrome

En la terminal donde está corriendo Chrome:
- Presiona `q`

---

## Paso 4: Ejecutar en Android

```powershell
# Navega al proyecto
cd "d:\Repositorios\Club Wilstermann App 2026"

# Ejecuta en Android
C:\src\flutter\bin\flutter.bat run

# O especifica el dispositivo si tienes varios:
C:\src\flutter\bin\flutter.bat run -d <DEVICE_ID>
```

---

## ⏱️ Primera Compilación

**IMPORTANTE:** La primera vez que compiles para Android tardará **5-10 minutos**.

Verás:
```
Running Gradle task 'assembleDebug'...
```

Esto es NORMAL. Gradle está:
- Descargando dependencias
- Compilando el código Dart a código nativo Android
- Generando el APK

**Las siguientes veces serán mucho más rápidas (30-60 segundos).**

---

## 🎮 Hot Reload en Android

Una vez que la app esté corriendo:

- **`r`** - Hot reload (cambios instantáneos)
- **`R`** - Hot restart (reinicio completo)
- **`q`** - Detener la app

---

## ✅ Verificar que Todo Funcione

Cuando la app se ejecute en Android, verás:

1. **Splash Screen** (3 segundos)
2. **Main Screen** con el nuevo bottom navigation
3. **Botón de Tienda** destacado en el centro
4. **Efectos de presión** al tocar cards y botones

---

## 🐛 Solución de Problemas

### "Gradle task assembleDebug failed"
```powershell
# Limpia y vuelve a intentar
C:\src\flutter\bin\flutter.bat clean
C:\src\flutter\bin\flutter.bat pub get
C:\src\flutter\bin\flutter.bat run
```

### "No devices found"
- Asegúrate de que el emulador esté completamente iniciado
- Espera a ver la pantalla de inicio de Android
- Vuelve a ejecutar `flutter devices`

### "Android SDK not found"
```powershell
# Configura el SDK
C:\src\flutter\bin\flutter.bat config --android-sdk="C:\Users\lucho\AppData\Local\Android\Sdk"
```

---

## 📱 Alternativa: Usar Dispositivo Físico

Si tienes un teléfono Android:

1. **Habilita Opciones de Desarrollador:**
   - Configuración → Acerca del teléfono
   - Toca 7 veces en "Número de compilación"

2. **Habilita Depuración USB:**
   - Configuración → Opciones de desarrollador
   - Activa "Depuración USB"

3. **Conecta por USB:**
   - Conecta el teléfono a la PC
   - Acepta "Permitir depuración USB"

4. **Ejecuta:**
   ```powershell
   C:\src\flutter\bin\flutter.bat run
   ```

---

**¡Buena suerte!** 🚀
