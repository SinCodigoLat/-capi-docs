---
layout: default
title: Backend Firebase
parent: Manual Técnico
nav_order: 5
---

# Backend Firebase

## Visión General

CAPI App utiliza Firebase como backend completo, proporcionando autenticación, base de datos, almacenamiento y funciones serverless.

## Firestore Database

### Estructura de Colecciones

#### `users`
Usuarios del sistema (doctores, pacientes, asistentes).

**Campos principales:**
- `email`, `displayName`, `photoUrl`
- `role` (Doctor, Paciente, Asistente)
- `isAdmin` (boolean)
- `clinica` (Reference)
- `permisos` (Struct con permisos granulares)
- Campos de auditoría: `modifiedBy`, `modifiedDate`, `actionType`

#### `clinicas`
Información de clínicas.

**Campos principales:**
- `nombre`, `email`, `telefono`
- `direccionClinica` (Struct)
- `horarioAtencion` (Array de Structs)
- `pagos` (ConfPagosStruct)
- `zoom` (ConfZoomStruct)
- `planSuscripcion` (Reference)
- `stripe_subscription_id`, `stripe_subscription_status`
- `credits_ai`, `limitePacientes`, `limitePersonal`

#### `citas`
Citas médicas.

**Campos principales:**
- `doctor` (Reference a users)
- `paciente` (Reference a users)
- `clinica` (Reference)
- `fecha`, `hora`
- `servicio` (Reference)
- `estado` (pendiente, confirmada, completada, cancelada)
- Campos de auditoría

#### `consultas`
Consultas médicas e historial clínico.

**Campos principales:**
- `doctor`, `paciente`, `clinica` (References)
- `fechaConsulta`
- `notasMedicas`
- `diagnostico`
- `antecedentes`, `signosVitales`, `exploracionFisica`
- `consentimientoInformado`
- Campos de auditoría

#### `chats`
Conversaciones de chat.

**Campos principales:**
- `users` (Array de References)
- `lastMessage`, `lastMessageTime`
- `unreadCount` (Map por usuario)
- `createdTime`

#### `audit_logs`
Logs de auditoría.

**Campos principales:**
- `userId`, `userEmail`, `userRole`
- `action` (CREATE, UPDATE, DELETE, READ)
- `resourceType` (Consulta, Cita, Usuario, etc.)
- `resourceId`
- `changes` (Map con cambios)
- `timestamp`
- `ipAddress`, `userAgent`

### Reglas de Seguridad

Las reglas de Firestore implementan:

1. **Validación por autenticación:**
   ```javascript
   function isAuthenticated() {
     return request.auth != null;
   }
   ```

2. **Validación por rol:**
   ```javascript
   function hasRole(role) {
     return getCurrentUser().role == role;
   }
   ```

3. **Validación por clínica:**
   ```javascript
   function belongsToSameClinic(clinicRef) {
     return getCurrentUser().clinica == clinicRef;
   }
   ```

4. **Validación de permisos:**
   ```javascript
   function hasPermission(permission) {
     return getCurrentUser().isAdmin == true || 
            getCurrentUser().permisos.todos == true || 
            getCurrentUser().permisos[permission] == true;
   }
   ```

## Firebase Authentication

### Métodos de Autenticación

- **Email/Password** - Autenticación principal
- **Google Sign-In** - Opcional (preparado)

### Flujo de Autenticación

1. Usuario se registra/inicia sesión
2. Firebase Auth crea sesión
3. App obtiene `UsersRecord` de Firestore
4. App valida rol y permisos
5. App redirige según rol

### Gestión de Sesiones

- Sesiones persistentes
- Refresh tokens automáticos
- Reautenticación para operaciones sensibles

## Firebase Storage

### Estructura de Almacenamiento

```
storage/
├── usuarios/
│   └── {userId}/
│       └── foto_perfil.jpg
├── clinicas/
│   └── {clinicaId}/
│       └── logo.png
├── pacientes/
│   └── {pacienteId}/
│       └── archivos/
│           ├── documentos/
│           └── imagenes/
└── consultas/
    └── {consultaId}/
        └── archivos_adjuntos/
```

### Reglas de Storage

- Validación por autenticación
- Validación por pertenencia a clínica
- Límites de tamaño de archivo
- Validación de tipos MIME

## Cloud Functions

### Funciones Principales

#### Notificaciones
- `sendNotification` - Enviar notificaciones push
- `clearAppBadge` - Limpiar badge de app
- `migrateExistingTokens` - Migrar tokens FCM

#### Email
- `sendTestEmail` - Enviar emails de prueba
- `chatEmailPeriodicCheck` - Verificar chats pendientes

#### Limpieza
- `cleanupDuplicateTokens` - Limpiar tokens duplicados
- `cleanupUserTokens` - Limpiar tokens de usuario

#### Backups
- `backupMedicalData` - Backup automático de datos médicos

#### Places API
- `getPlacesAutocomplete` - Autocompletado de direcciones
- `getPlaceDetails` - Detalles de lugar

### Estructura de Functions

```
firebase/functions/
├── index.js                    # Punto de entrada
├── notification_service.js     # Servicio de notificaciones
├── email_service.js            # Servicio de email
├── backup_medical_data.js      # Backup de datos
└── ...
```

## Firebase Cloud Messaging

### Configuración

- **Web:** `firebase-messaging-sw.js`
- **Android:** Configuración en `AndroidManifest.xml`
- **iOS:** Configuración en `Info.plist`

### Flujo de Notificaciones

1. Cloud Function o app envía notificación
2. FCM entrega a dispositivos
3. App recibe y procesa notificación
4. App muestra notificación local
5. App actualiza estado si es necesario

## Índices de Firestore

### Índices Compuestos

- `citas`: `clinica` + `fecha` + `estado`
- `consultas`: `clinica` + `paciente` + `fechaConsulta`
- `chats`: `users` (array-contains) + `lastMessageTime`

### Configuración

Los índices se definen en `firestore.indexes.json` y se despliegan con:

```bash
firebase deploy --only firestore:indexes
```

## Próximos Pasos

1. [Autenticación y Roles](./06-autenticacion-roles.md) - Sistema de permisos
2. [Integraciones](./07-integraciones.md) - Servicios externos

---

**Anterior:** [Estructura del Proyecto ←](./04-estructura-proyecto.md) | **Siguiente:** [Autenticación y Roles →](./06-autenticacion-roles.md)

