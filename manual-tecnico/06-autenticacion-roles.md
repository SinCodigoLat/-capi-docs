---
layout: default
title: Autenticación y Roles
parent: Manual Técnico
nav_order: 6
---

# Autenticación y Roles

## Sistema de Roles

### Roles Disponibles

CAPI App define tres roles principales:

1. **Doctor** - Profesional de la salud
   - Variante: Doctor Admin (`isAdmin: true`)
2. **Paciente** - Usuario paciente
3. **Asistente** - Asistente de clínica

### Estructura de Roles

```dart
enum Roles {
  Doctor,
  Asistente,
  Paciente,
}
```

### Lógica de Roles

**Importante:** Un administrador de clínica es un Doctor con `isAdmin: true`.

- Todos los administradores tienen: `role: "Doctor"` + `isAdmin: true`
- Un doctor regular tiene: `role: "Doctor"` + `isAdmin: false`
- El campo `role` nunca debe ser "Administrador"

## Sistema de Permisos

### Permisos Granulares

El sistema incluye 15+ permisos específicos:

```dart
PermisosStruct {
  verCitas: bool
  crearCitas: bool
  editarCitas: bool
  eliminarCitas: bool
  
  verPacientes: bool
  crearPacientes: bool
  editarPacientes: bool
  
  verConsultas: bool
  crearConsultas: bool
  editarConsultas: bool
  
  verEquipo: bool
  gestionarEquipo: bool
  
  verServicios: bool
  gestionarServicios: bool
  
  configurarClinica: bool
  
  todos: bool  // Permiso maestro
}
```

### Validación de Permisos

#### En el Frontend

```dart
import '/services/permissions_validator.dart';

if (PermissionsValidator.hasPermission('crearCitas')) {
  // Mostrar botón de crear cita
}
```

#### En Firestore Rules

```javascript
function hasPermission(permission) {
  return isAuthenticated() && 
         (getCurrentUser().isAdmin == true || 
          getCurrentUser().permisos.todos == true || 
          getCurrentUser().permisos[permission] == true);
}
```

## Control de Acceso

### Por Rol

```dart
switch (userRole) {
  case 'Doctor':
    if (isAdmin) {
      // Acceso completo a la clínica
    } else {
      // Solo sus propias citas/consultas
    }
    break;
  case 'Paciente':
    // Solo sus propios datos
    break;
  case 'Asistente':
    // Según permisos asignados
    break;
}
```

### Por Clínica

Todas las operaciones validan pertenencia a clínica:

```dart
if (cita.clinica?.id != currentUser.clinica?.id) {
  // Acceso denegado
}
```

### Por Permisos Específicos

```dart
if (!PermissionsValidator.hasPermission('editarCitas')) {
  // Mostrar AccessDeniedWidget
}
```

## Flujo de Autenticación

### Registro

1. Usuario completa formulario de registro
2. Se crea cuenta en Firebase Auth
3. Se crea `UsersRecord` en Firestore
4. Se asigna rol inicial
5. Si es Doctor Admin, se crea clínica automáticamente

### Login

1. Usuario ingresa credenciales
2. Firebase Auth valida credenciales
3. App obtiene `UsersRecord` de Firestore
4. App valida rol y estado
5. App redirige según rol:
   - Doctor → Menu Principal Clínica
   - Paciente → Menu Principal Paciente
   - Asistente → Menu Principal Clínica

### Validación de Rol

El widget `ValidacionRolWidget` se ejecuta después del login para:

1. Verificar que existe `UsersRecord`
2. Validar rol del usuario
3. Verificar estado de suscripción (si aplica)
4. Redirigir a la vista apropiada

## Reautenticación

Para operaciones sensibles (eliminar cuenta, cambiar contraseña):

```dart
await FirebaseAuth.instance.reauthenticateWithCredential(credential);
```

## Sistema de Invitaciones

### Flujo de Invitación

1. Doctor Admin genera código de invitación
2. Código se almacena en Firestore
3. Usuario ingresa código en app
4. App valida código y clínica
5. Usuario se asocia a la clínica
6. Se asignan permisos según rol

### Validación de Invitación

```dart
Future<bool> validarInvitacionClinica(String codigo) async {
  // Buscar código en Firestore
  // Validar que existe y no está usado
  // Validar que la clínica existe
  // Retornar resultado
}
```

## Auditoría de Acceso

Todas las operaciones importantes se registran en `audit_logs`:

```dart
await AuditLogger.log(
  action: 'CREATE',
  resourceType: 'Consulta',
  resourceId: consultaId,
  changes: {...},
);
```

## Próximos Pasos

1. [Integraciones](./07-integraciones.md) - Servicios externos
2. [Despliegue](./08-despliegue.md) - Build y despliegue

---

**Anterior:** [Backend Firebase ←](./05-backend-firebase.md) | **Siguiente:** [Integraciones →](./07-integraciones.md)

