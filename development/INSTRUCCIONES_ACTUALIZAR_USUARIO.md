# Instrucciones para Actualizar Usuario y Saltar Suscripción

## Problema Identificado
El usuario tiene `etapaIncorporacion: inicio_01`, por lo que va a la página de suscripción, pero hay un problema de navegación que causa 404.

## Solución: Actualizar el Usuario

### 1. Ir a Firebase Console
- Ve a [Firebase Console](https://console.firebase.google.com/project/capideveloper-6078c/firestore)
- Navega a Firestore Database

### 2. Actualizar el Usuario
- Ve a la colección `users`
- Busca el documento con ID: `4oTyzcBu00WD7x0wB8IffBRY6ym2`
- Haz clic en el documento para editarlo

### 3. Cambiar los siguientes campos:
```json
{
  "etapaIncorporacion": "adquirioSuscripcion_02",
  "configCompleta": true
}
```

## Resultado Esperado
Después de estos cambios:
1. El usuario saltará la página de suscripción
2. Irá directamente a `CompletePerfilProfesionalWidget` (completar perfil profesional)
3. No debería aparecer la página 404

## Flujo Correcto
- `inicio_01` → Página de suscripción (problema actual)
- `adquirioSuscripcion_02` → Completar perfil profesional ✅
- `completoPerfil_03` → Configuración onboarding
- `configuroNegocio_04` → Dashboard de pacientes

## Verificación
- Recarga la aplicación
- Deberías ir directamente a la página de completar perfil profesional

