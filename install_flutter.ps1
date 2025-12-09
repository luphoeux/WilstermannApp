# Script de Instalacion Automatica de Flutter
# Para Club Wilstermann App 2026

Write-Host "Instalando Flutter para Club Wilstermann App..." -ForegroundColor Cyan

# Definir rutas
$flutterPath = "C:\src\flutter"
$flutterZip = "$env:TEMP\flutter_sdk.zip"
$flutterUrl = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip"

# Crear directorio si no existe
Write-Host "Creando directorio de instalacion..." -ForegroundColor Yellow
if (-not (Test-Path "C:\src")) {
    New-Item -ItemType Directory -Path "C:\src" -Force | Out-Null
}

# Verificar si Flutter ya esta instalado
if (Test-Path "$flutterPath\bin\flutter.bat") {
    Write-Host "Flutter ya esta instalado en $flutterPath" -ForegroundColor Green
    & "$flutterPath\bin\flutter.bat" --version
    exit 0
}

# Descargar Flutter
Write-Host "Descargando Flutter SDK (esto puede tomar varios minutos)..." -ForegroundColor Yellow
try {
    Import-Module BitsTransfer
    Start-BitsTransfer -Source $flutterUrl -Destination $flutterZip -Description "Descargando Flutter SDK"
    Write-Host "Descarga completada" -ForegroundColor Green
} catch {
    Write-Host "Error al descargar Flutter: $_" -ForegroundColor Red
    Write-Host "Por favor, descarga manualmente desde: $flutterUrl" -ForegroundColor Yellow
    exit 1
}

# Extraer Flutter
Write-Host "Extrayendo Flutter SDK..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $flutterZip -DestinationPath "C:\src" -Force
    Write-Host "Extraccion completada" -ForegroundColor Green
} catch {
    Write-Host "Error al extraer Flutter: $_" -ForegroundColor Red
    exit 1
}

# Limpiar archivo temporal
Remove-Item $flutterZip -Force -ErrorAction SilentlyContinue

# Agregar Flutter al PATH del usuario
Write-Host "Configurando variables de entorno..." -ForegroundColor Yellow
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$flutterPath\bin*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$flutterPath\bin", "User")
    Write-Host "Flutter agregado al PATH" -ForegroundColor Green
} else {
    Write-Host "Flutter ya esta en el PATH" -ForegroundColor Green
}

# Actualizar PATH en la sesion actual
$env:Path = "$env:Path;$flutterPath\bin"

# Verificar instalacion
Write-Host ""
Write-Host "Verificando instalacion de Flutter..." -ForegroundColor Cyan
& "$flutterPath\bin\flutter.bat" --version

Write-Host ""
Write-Host "Ejecutando Flutter Doctor..." -ForegroundColor Cyan
& "$flutterPath\bin\flutter.bat" doctor

Write-Host ""
Write-Host "Instalacion completada!" -ForegroundColor Green
Write-Host "IMPORTANTE: Cierra y vuelve a abrir PowerShell para que los cambios surtan efecto" -ForegroundColor Yellow
Write-Host ""
Write-Host "Proximos pasos:" -ForegroundColor Cyan
Write-Host "  1. Cierra esta ventana de PowerShell"
Write-Host "  2. Abre una NUEVA ventana de PowerShell"
Write-Host "  3. Ejecuta: flutter doctor"
Write-Host "  4. Instala las dependencias faltantes segun las indicaciones"
Write-Host ""
Write-Host "Para crear la app de Wilstermann, ejecuta:" -ForegroundColor Cyan
Write-Host "  flutter create --org com.clubwilstermann wilstermann_app"
