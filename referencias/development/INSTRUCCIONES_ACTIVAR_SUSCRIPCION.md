# Instrucciones para Activar Suscripción de Prueba

## Objetivo
Modificar la base de datos para que tu usuario de test salte la página de suscripción y vaya directamente al dashboard.

## Pasos a seguir:

### 1. Ir a Firebase Console
- Ve a [Firebase Console](https://console.firebase.google.com/project/capideveloper-6078c/firestore)
- Navega a Firestore Database

### 2. Actualizar la Clínica
- Ve a la colección `clinica`
- Busca el documento con ID: `SKP9oAgx3r3PbM8Q1oDf`
- Haz clic en el documento para editarlo

### 3. Agregar los siguientes campos:
Agrega estos campos al documento de la clínica:

```json
{
  "stripeSubscriptionId": "sub_test_123456789",
  "subscriptionStatus": "active",
  "planName": "Premium",
  "subscriptionStartDate": "2025-09-15T23:00:00.000Z",
  "subscriptionEndDate": "2025-10-15T23:00:00.000Z"
}
```

### 4. Actualizar el Usuario (Opcional)
También puedes actualizar el usuario para completar la configuración:

- Ve a la colección `users`
- Busca el documento con ID: `4oTyzcBu00WD7x0wB8IffBRY6ym2`
- Cambia el campo `etapaIncorporacion` de `inicio_01` a `adquirioSuscripcion_02`
- Cambia el campo `configCompleta` de `false` a `true`

## Resultado Esperado
Después de estos cambios:
1. La página de suscripción detectará que ya tienes una suscripción activa
2. Te mostrará la pantalla de bienvenida con el botón "Ir al dashboard"
3. Podrás acceder directamente al dashboard sin pasar por la selección de planes

## Verificación
- Recarga la página `http://localhost:3000/planSuscripcion`
- Deberías ver la pantalla de bienvenida en lugar de los planes de suscripción

