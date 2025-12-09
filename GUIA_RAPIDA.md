# Guia Rapida de Inicio - Club Wilstermann App

## ✅ Estado de la Instalación

### Completado:
- ✅ Flutter SDK 3.24.5 instalado en `C:\src\flutter`
- ✅ Git instalado
- ✅ Proyecto Flutter creado
- ✅ Estructura de carpetas configurada
- ✅ Archivos de constantes creados (colores, strings, rutas)
- ✅ Tema de la aplicación configurado
- ✅ Pantalla de splash creada

### Pendiente:
- ⚠️ Habilitar Modo Desarrollador en Windows (requerido para Flutter)
- ⚠️ Instalar dependencias del proyecto
- ⚠️ Configurar emulador o dispositivo físico

---

## 🔧 Pasos Siguientes

### 1. Habilitar Modo Desarrollador en Windows

**IMPORTANTE:** Flutter requiere que el Modo Desarrollador esté habilitado en Windows para crear symlinks.

**Opción A - Usando PowerShell (Recomendado):**
```powershell
start ms-settings:developers
```

**Opción B - Manual:**
1. Presiona `Windows + I` para abrir Configuración
2. Ve a "Privacidad y seguridad" → "Para desarrolladores"
3. Activa "Modo de desarrollador"
4. Confirma cuando se te solicite

### 2. Reiniciar PowerShell

Después de habilitar el Modo Desarrollador:
1. Cierra todas las ventanas de PowerShell
2. Abre una NUEVA ventana de PowerShell
3. Navega al directorio del proyecto:
```powershell
cd "d:\Repositorios\Club Wilstermann App 2026"
```

### 3. Instalar Dependencias

```powershell
C:\src\flutter\bin\flutter.bat pub get
```

### 4. Verificar Instalación

```powershell
C:\src\flutter\bin\flutter.bat doctor
```

### 5. Ejecutar la App

**En un emulador Android:**
```powershell
# Primero, inicia un emulador desde Android Studio
# Luego ejecuta:
C:\src\flutter\bin\flutter.bat run
```

**En Chrome (Web):**
```powershell
C:\src\flutter\bin\flutter.bat run -d chrome
```

**En Windows (Desktop):**
```powershell
C:\src\flutter\bin\flutter.bat run -d windows
```

---

## 📱 Configurar Emulador Android

### Opción 1: Desde Android Studio
1. Abre Android Studio
2. Ve a `Tools` → `Device Manager`
3. Haz clic en `Create Device`
4. Selecciona un dispositivo (ej: Pixel 6)
5. Descarga una imagen del sistema (ej: Android 13)
6. Finaliza la configuración
7. Inicia el emulador

### Opción 2: Desde la línea de comandos
```powershell
# Listar emuladores disponibles
C:\src\flutter\bin\flutter.bat emulators

# Iniciar un emulador
C:\src\flutter\bin\flutter.bat emulators --launch <emulator_id>
```

---

## 🔍 Solución de Problemas

### Error: "symlink support is required"
- **Solución:** Habilita el Modo Desarrollador (ver Paso 1)

### Error: "No devices found"
- **Solución:** Inicia un emulador o conecta un dispositivo físico con USB debugging

### Error: "Android licenses not accepted"
```powershell
C:\src\flutter\bin\flutter.bat doctor --android-licenses
```
Presiona `y` para aceptar todas las licencias

### Error: "Unable to locate Android SDK"
1. Abre Android Studio
2. Ve a `File` → `Settings` → `Appearance & Behavior` → `System Settings` → `Android SDK`
3. Anota la ruta del SDK
4. Configura la variable de entorno `ANDROID_HOME` con esa ruta

---

## 📂 Estructura del Proyecto

```
lib/
├── core/
│   ├── constants/
│   │   ├── colors.dart          ✅ Colores del club
│   │   ├── strings.dart         ✅ Textos de la app
│   │   └── routes.dart          ✅ Rutas de navegación
│   ├── theme/
│   │   └── app_theme.dart       ✅ Tema personalizado
│   └── utils/
├── data/
│   ├── models/                  📝 Próximamente
│   ├── repositories/            📝 Próximamente
│   └── services/                📝 Próximamente
├── presentation/
│   ├── screens/
│   │   └── splash_screen.dart   ✅ Pantalla de inicio
│   └── widgets/                 📝 Próximamente
├── providers/                   📝 Próximamente
└── main.dart                    ✅ Punto de entrada
```

---

## 🎨 Características Implementadas

### Colores Oficiales
- Rojo Wilstermann: `#E30613`
- Blanco: `#FFFFFF`
- Azul: `#0066CC`

### Tipografía
- Títulos: Montserrat (Bold, SemiBold)
- Cuerpo: Roboto (Regular, Bold)

### Pantallas
- ✅ Splash Screen con animaciones

---

## 📋 Próximos Pasos de Desarrollo

1. **Autenticación**
   - Pantalla de login
   - Pantalla de registro
   - Recuperación de contraseña

2. **Home**
   - Dashboard principal
   - Navegación inferior
   - Últimas noticias

3. **Membresías**
   - Catálogo de membresías
   - Detalle de membresía
   - Proceso de compra

4. **Perfil**
   - Ver información personal
   - Editar perfil
   - Historial de compras

5. **Admin**
   - Dashboard administrativo
   - Gestión de usuarios
   - Gestión de membresías
   - Reportes

---

## 🚀 Comandos Útiles

```powershell
# Ver versión de Flutter
C:\src\flutter\bin\flutter.bat --version

# Limpiar build
C:\src\flutter\bin\flutter.bat clean

# Actualizar dependencias
C:\src\flutter\bin\flutter.bat pub upgrade

# Listar dispositivos
C:\src\flutter\bin\flutter.bat devices

# Ejecutar en modo release
C:\src\flutter\bin\flutter.bat run --release

# Generar APK
C:\src\flutter\bin\flutter.bat build apk

# Ejecutar tests
C:\src\flutter\bin\flutter.bat test
```

---

**¡Vamos Aviador! 🔴⚪🔵**
