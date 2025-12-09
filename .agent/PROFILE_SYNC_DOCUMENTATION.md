# Sincronización del Perfil de Usuario

## Resumen
Se ha implementado un sistema centralizado de gestión de perfiles que sincroniza automáticamente el nombre del usuario entre el header del `HomeScreen` y la pantalla de `ProfileScreen`.

## Cambios Realizados

### 1. Nuevo Servicio: `ProfileService`
**Archivo**: `lib/core/services/profile_service.dart`

Se creó un servicio singleton que gestiona:
- **Nombre completo del perfil**: Almacena el nombre completo del usuario (ej: "Luis Perez")
- **Iniciales**: Calcula y almacena automáticamente las iniciales para mostrar en avatares (ej: "LP")
- **Primer nombre**: Extrae el primer nombre para saludos personalizados (ej: "Luis")
- **Persistencia**: Usa `SharedPreferences` para mantener los datos entre sesiones

#### Métodos principales:
```dart
setProfileName(String name)      // Guarda el nombre del perfil
getProfileName()                 // Obtiene el nombre completo
getProfileInitials()             // Obtiene las iniciales (ej: "LP")
getFirstName()                   // Obtiene el primer nombre (ej: "Luis")
hasProfile()                     // Verifica si hay un perfil configurado
clearProfile()                   // Limpia los datos del perfil
```

### 2. Actualización de `AuthService`
**Archivo**: `lib/core/services/auth_service.dart`

- Integrado con `ProfileService`
- Al cerrar sesión (`logout()`), también se limpian los datos del perfil
- Esto asegura que no queden datos residuales del usuario anterior

### 3. Actualización de `HomeScreen`
**Archivo**: `lib/presentation/screens/home_screen.dart`

**Antes**: El nombre se extraía del email (`admin@gmail.com` → "Admin")

**Ahora**: 
- Usa `ProfileService` para obtener el nombre real del perfil
- Muestra las iniciales correctas en el avatar circular
- Saludo personalizado: "Buenas, [Primer Nombre]"
- Si no hay perfil, usa el email como fallback

### 4. Actualización de `ProfileScreen`
**Archivo**: `lib/presentation/screens/profile_screen.dart`

**Antes**: Nombre hardcodeado (`'Luis Perez'`)

**Ahora**:
- Carga el nombre del perfil desde `ProfileService` al iniciar
- Muestra las iniciales dinámicas en el avatar
- Al cambiar de perfil, actualiza el `ProfileService`
- Si no hay perfil pero el usuario está logueado, crea un perfil por defecto

### 5. Actualización de `AddProfileScreen`
**Archivo**: `lib/presentation/screens/add_profile_screen.dart`

**Antes**: Solo mostraba un mensaje de éxito

**Ahora**:
- Al registrar un nuevo perfil, guarda el nombre completo en `ProfileService`
- Construye el nombre completo: `Nombres + Apellidos`
- Mensaje de éxito personalizado con el nombre del perfil

### 6. Actualización de `MainScreen`
**Archivo**: `lib/presentation/screens/main_screen.dart`

**Antes**: Las pantallas se creaban una sola vez en una lista estática

**Ahora**:
- Las pantallas se reconstruyen dinámicamente al cambiar de tab
- Esto asegura que `HomeScreen` se actualice cuando volvemos desde `ProfileScreen`
- Garantiza la sincronización en tiempo real

### 7. Corrección de Bug
**Archivo**: `lib/presentation/screens/purchase/register_profile_modal.dart`

- Corregido error de compilación en `DropdownButtonFormField`
- Cambiado `initialValue` por `value` (parámetro correcto en Flutter actual)

## Flujo de Sincronización

### Escenario 1: Usuario inicia sesión por primera vez
1. Usuario hace login → `AuthService.login()`
2. `ProfileScreen` detecta que no hay perfil
3. Crea perfil por defecto: "Usuario Principal"
4. `HomeScreen` muestra: "Buenas, Usuario" con iniciales "UP"

### Escenario 2: Usuario registra un nuevo perfil
1. Usuario va a "Añadir perfil" → `AddProfileScreen`
2. Completa el formulario (ej: "Luis Perez")
3. Al guardar → `ProfileService.setProfileName("Luis Perez")`
4. Vuelve a `ProfileScreen` → muestra "Luis Perez" con iniciales "LP"
5. Va a `HomeScreen` → muestra "Buenas, Luis" con iniciales "LP"

### Escenario 3: Usuario cambia de perfil
1. Usuario va a "Cambiar perfil" en `ProfileScreen`
2. Selecciona otro perfil (ej: "María García")
3. `ProfileService.setProfileName("María García")` se ejecuta
4. `ProfileScreen` actualiza inmediatamente las iniciales a "MG"
5. Al volver a `HomeScreen` → muestra "Buenas, María" con iniciales "MG"

### Escenario 4: Usuario cierra sesión
1. Usuario hace logout → `AuthService.logout()`
2. Se ejecuta `ProfileService.clearProfile()`
3. Todos los datos del perfil se eliminan
4. `HomeScreen` vuelve a mostrar "Club Wilstermann" sin perfil

## Beneficios

✅ **Sincronización automática**: El nombre se actualiza en todas las pantallas
✅ **Persistencia**: Los datos se mantienen entre sesiones
✅ **Iniciales inteligentes**: Se calculan automáticamente (1 o 2 letras)
✅ **Código limpio**: Un solo punto de verdad para los datos del perfil
✅ **Fácil mantenimiento**: Cambios futuros solo requieren modificar `ProfileService`
✅ **Sin duplicación**: No hay nombres hardcodeados en múltiples lugares

## Próximos Pasos Sugeridos

1. **Múltiples perfiles**: Extender `ProfileService` para soportar varios perfiles por usuario
2. **Avatar personalizado**: Permitir subir fotos de perfil
3. **Datos adicionales**: Guardar más información del perfil (email, teléfono, etc.)
4. **Validación**: Agregar validación de nombres (longitud mínima, caracteres permitidos)
5. **Backend**: Integrar con un backend real para sincronizar perfiles en la nube
