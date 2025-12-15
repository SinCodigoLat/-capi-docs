---
layout: default
title: Estructura del Proyecto
parent: Manual Técnico
nav_order: 4
---

# Estructura del Proyecto

## Organización General

```
Capi-App/
├── lib/                          # Código fuente principal
│   ├── actions/                 # Acciones de FlutterFlow
│   ├── app_constants.dart       # Constantes de la aplicación
│   ├── app_state.dart           # Estado global
│   ├── auth/                    # Autenticación
│   ├── backend/                 # Backend y schemas
│   ├── chat/                    # Sistema de chat
│   ├── clinica/                 # Módulo de clínica
│   ├── componentes/             # Componentes reutilizables
│   ├── components/              # Componentes adicionales
│   ├── custom_code/             # Código personalizado
│   ├── flutter_flow/            # Framework FlutterFlow
│   ├── models/                  # Modelos de datos
│   ├── paciente/                # Módulo de paciente
│   ├── services/                # Servicios de negocio
│   └── validacion_rol/          # Validación de roles
├── firebase/                    # Firebase Functions y config
│   ├── functions/               # Cloud Functions
│   ├── public/                  # Archivos públicos
│   ├── firestore.rules         # Reglas de seguridad
│   └── storage.rules           # Reglas de Storage
├── android/                     # Configuración Android
├── ios/                         # Configuración iOS
├── web/                         # Configuración Web
├── docs/                        # Documentación
└── assets/                       # Recursos estáticos
```

## Estructura de `lib/`

### `auth/`
Manejo de autenticación con Firebase Auth.

```
auth/
├── firebase_auth/               # Implementación Firebase Auth
│   ├── auth_util.dart         # Utilidades de autenticación
│   └── ...
└── auth_manager.dart           # Gestor de autenticación
```

### `backend/`
Schemas y acceso a datos de Firestore.

```
backend/
├── schema/                      # Schemas de Firestore
│   ├── structs/                # Estructuras de datos
│   ├── enums/                  # Enumeraciones
│   └── *.dart                  # Records de colecciones
├── api_requests/               # Llamadas a APIs externas
│   └── api_calls.dart         # Definiciones de APIs
└── backend.dart                # Exportaciones principales
```

### `clinica/`
Módulo completo para gestión de clínica.

```
clinica/
├── menu_principal/             # Menú principal de clínica
│   ├── estadisticas/          # Dashboard de estadísticas
│   ├── calendario/            # Calendario de citas
│   ├── conversaciones/        # Lista de chats
│   ├── citas/                 # Gestión de citas
│   ├── consultas/             # Gestión de consultas
│   ├── perfil/                # Perfil del doctor
│   └── mi_plan/               # Gestión de suscripción
├── otraspaginas/              # Páginas adicionales
│   ├── detalles_paciente/    # Detalles de paciente
│   ├── crear_servicio/        # Crear servicio médico
│   ├── equipo/                # Gestión de equipo
│   └── ...
├── configuracion/             # Configuración de clínica
├── crear_cuenta/              # Registro de cuenta
├── login/                      # Login
└── ...
```

### `paciente/`
Módulo completo para pacientes.

```
paciente/
├── menu/                       # Menú principal paciente
│   ├── citaspaciente/        # Citas del paciente
│   ├── conversacionespaciente/ # Chats del paciente
│   └── misdoctores_pac/      # Doctores del paciente
├── perfil/                     # Perfil del paciente
├── buscadordoctores/          # Búsqueda de doctores
└── ...
```

### `services/`
Servicios de negocio y utilidades.

```
services/
├── subscription_service.dart    # Gestión de suscripciones
├── revenuecat_service.dart     # RevenueCat (iOS)
├── notification_service.dart   # Notificaciones push
├── permissions_manager.dart    # Gestión de permisos
├── chat_notification_service.dart # Notificaciones de chat
└── ...
```

### `custom_code/`
Código personalizado y acciones.

```
custom_code/
├── actions/                    # Acciones personalizadas
│   ├── validar_suscripcion_action.dart
│   ├── receta_pdf.dart
│   ├── busqueda_*.dart
│   └── ...
└── widgets/                    # Widgets personalizados
```

## Convenciones de Código

### Nomenclatura

- **Archivos:** `snake_case.dart`
- **Clases:** `PascalCase`
- **Variables:** `camelCase`
- **Constantes:** `SCREAMING_SNAKE_CASE`

### Estructura de Widgets

```dart
class MiWidget extends StatefulWidget {
  // Constructor y propiedades
}

class _MiWidgetState extends State<MiWidget> {
  // Estado local
  // Métodos de ciclo de vida
  // Métodos de negocio
  // Build method
}
```

### Estructura de Servicios

```dart
class MiService {
  static final MiService _instance = MiService._internal();
  factory MiService() => _instance;
  MiService._internal();
  
  // Métodos públicos
}
```

## Patrones Utilizados

### Singleton
Para servicios compartidos:
```dart
class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
}
```

### Repository Pattern
Para acceso a datos:
```dart
class UsersRepository {
  Future<List<UsersRecord>> getUsers();
  Future<void> createUser(UsersRecord user);
}
```

### Service Layer
Para lógica de negocio:
```dart
class BusinessService {
  Future<void> processSubscription();
}
```

## Archivos Importantes

### `app_constants.dart`
Constantes globales de la aplicación:
- API keys
- URLs
- Configuraciones

### `app_state.dart`
Estado global de la aplicación:
- Usuario actual
- Configuración
- Preferencias

### `index.dart`
Exportaciones principales de páginas y componentes.

## Próximos Pasos

1. [Backend Firebase](./05-backend-firebase.md) - Entiende Firestore y servicios
2. [Autenticación y Roles](./06-autenticacion-roles.md) - Sistema de permisos

---

**Anterior:** [Instalación y Configuración ←](./03-instalacion-configuracion.md) | **Siguiente:** [Backend Firebase →](./05-backend-firebase.md)

