# 🔴⚪🔵 Club Wilstermann App 2026

Aplicación móvil oficial para la gestión de membresías y información del Club Wilstermann.

## 📱 Características Principales

### Para Usuarios
- 🏟️ **Información del Club**: Noticias, historia, plantilla de jugadores
- 🎫 **Compra de Membresías**: Sistema de compra de diferentes tipos de membresías
- 👤 **Perfil de Usuario**: Gestión de datos personales y membresías activas
- 📊 **Dashboard Personal**: Vista de beneficios, partidos próximos, estadísticas
- 🔔 **Notificaciones**: Alertas de partidos, eventos y ofertas especiales
- 💳 **Métodos de Pago**: Integración con pasarelas de pago locales

### Para Administradores
- 📈 **Panel de Control**: Estadísticas de ventas, usuarios activos, ingresos
- 👥 **Gestión de Usuarios**: Ver, editar y administrar usuarios registrados
- 🎟️ **Gestión de Membresías**: Crear, editar y administrar tipos de membresías
- 📰 **Gestión de Contenido**: Publicar noticias, eventos y actualizaciones
- 💰 **Reportes Financieros**: Informes de ventas y transacciones
- 🔐 **Control de Acceso**: Gestión de permisos y roles

## 🛠️ Tecnologías

- **Framework**: Flutter 3.24.5
- **Lenguaje**: Dart
- **Backend**: Firebase / API REST personalizada
- **Base de Datos**: Firestore / PostgreSQL
- **Autenticación**: Firebase Auth / JWT
- **Pagos**: Stripe / Mercado Pago / Pagos locales
- **Notificaciones**: Firebase Cloud Messaging

## 📋 Tipos de Membresías Planificadas

1. **Membresía Básica**
   - Acceso a noticias exclusivas
   - Descuentos en merchandising (10%)
   - Newsletter semanal

2. **Membresía Premium**
   - Todo lo de Básica +
   - Descuentos en entradas (15%)
   - Acceso prioritario a eventos
   - Descuentos en merchandising (20%)

3. **Membresía VIP**
   - Todo lo de Premium +
   - Acceso a zonas VIP del estadio
   - Meet & Greet con jugadores (eventos especiales)
   - Descuentos en entradas (30%)
   - Merchandising exclusivo

4. **Membresía Familiar**
   - Hasta 4 miembros
   - Beneficios de Membresía Premium
   - Actividades familiares exclusivas

## 🎨 Diseño

### Colores Oficiales
- **Rojo**: #E30613 (Principal)
- **Blanco**: #FFFFFF (Secundario)
- **Azul**: #0066CC (Acento)
- **Gris Oscuro**: #2C3E50 (Texto)
- **Gris Claro**: #ECF0F1 (Fondos)

### Tipografía
- **Títulos**: Montserrat Bold
- **Subtítulos**: Montserrat SemiBold
- **Cuerpo**: Roboto Regular

## 📁 Estructura del Proyecto

```
wilstermann_app/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   │   ├── constants/
│   │   │   ├── colors.dart
│   │   │   ├── strings.dart
│   │   │   └── routes.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   └── utils/
│   │       ├── validators.dart
│   │       └── formatters.dart
│   ├── data/
│   │   ├── models/
│   │   │   ├── user.dart
│   │   │   ├── membership.dart
│   │   │   └── payment.dart
│   │   ├── repositories/
│   │   │   ├── user_repository.dart
│   │   │   ├── membership_repository.dart
│   │   │   └── payment_repository.dart
│   │   └── services/
│   │       ├── api_service.dart
│   │       ├── auth_service.dart
│   │       └── payment_service.dart
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── auth/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── register_screen.dart
│   │   │   ├── home/
│   │   │   │   └── home_screen.dart
│   │   │   ├── memberships/
│   │   │   │   ├── memberships_list_screen.dart
│   │   │   │   └── membership_detail_screen.dart
│   │   │   ├── profile/
│   │   │   │   └── profile_screen.dart
│   │   │   └── admin/
│   │   │       ├── admin_dashboard_screen.dart
│   │   │       ├── users_management_screen.dart
│   │   │       └── memberships_management_screen.dart
│   │   └── widgets/
│   │       ├── custom_button.dart
│   │       ├── custom_text_field.dart
│   │       ├── membership_card.dart
│   │       └── loading_indicator.dart
│   └── providers/
│       ├── auth_provider.dart
│       ├── user_provider.dart
│       └── membership_provider.dart
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   └── placeholder.png
│   └── fonts/
├── test/
└── pubspec.yaml
```

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK 3.24.5 o superior
- Dart SDK 3.0 o superior
- Android Studio / VS Code
- Git

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/clubwilstermann/wilstermann-app-2026.git
cd wilstermann-app-2026
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar Firebase** (si se usa)
- Crear proyecto en Firebase Console
- Descargar `google-services.json` (Android)
- Descargar `GoogleService-Info.plist` (iOS)
- Colocar en las carpetas correspondientes

4. **Ejecutar la aplicación**
```bash
flutter run
```

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Estado
  provider: ^6.1.1
  
  # Navegación
  go_router: ^13.0.0
  
  # HTTP
  dio: ^5.4.0
  
  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  firebase_messaging: ^14.7.9
  
  # UI
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  
  # Pagos
  stripe_payment: ^1.1.4
  
  # Utilidades
  intl: ^0.18.1
  shared_preferences: ^2.2.2
```

## 🧪 Testing

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar tests con coverage
flutter test --coverage

# Ver reporte de coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📱 Build

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 👥 Equipo de Desarrollo

- **Product Owner**: [Nombre]
- **Desarrollador Flutter**: [Nombre]
- **Diseñador UI/UX**: [Nombre]
- **Backend Developer**: [Nombre]

## 📄 Licencia

Copyright © 2026 Club Wilstermann. Todos los derechos reservados.

## 🔗 Enlaces

- [Sitio Web Oficial](https://www.wilstermann.com)
- [Facebook](https://facebook.com/wilstermann)
- [Twitter](https://twitter.com/wilstermann)
- [Instagram](https://instagram.com/wilstermann)

---

**¡Vamos Aviador! 🔴⚪🔵**
