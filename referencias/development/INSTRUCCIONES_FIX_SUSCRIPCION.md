# 🔧 Instrucciones para Corregir la Validación de Suscripción

## Problema Identificado
El sistema está buscando el campo `stripe_subscription_id` en la clínica, pero la clínica tiene `stripeSubscriptionId`. Esto causa que la validación falle y te redirija a la página de plan de suscripción.

## Solución: Actualizar la Clínica en Firebase Console

### Paso 1: Acceder a Firebase Console
1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona el proyecto `capideveloper-6078c`
3. Ve a **Firestore Database**

### Paso 2: Localizar la Clínica
1. Busca la colección `clinica`
2. Encuentra el documento con ID `SKP9oAgx3r3PbM8Q1oDf`
3. Haz clic en el documento para editarlo

### Paso 3: Actualizar los Campos
Agrega o actualiza los siguientes campos en el documento de la clínica:

```json
{
  "stripe_subscription_id": "sub_1QK1234567890abcdef",
  "stripe_subscription_status": "active", 
  "stripe_subscription_product_id": "prod_1234567890",
  "stripe_subscription_price_id": "price_1234567890",
  "stripe_plan_end_date": "2034-12-31T23:59:59.999Z",
  "nombrePlan": "Premium",
  "limitePersonal": 10,
  "limitePacientes": 1000,
  "pacientesUsados": 0,
  "modifiedDate": "2025-01-15T22:50:51.764Z",
  "actionType": "UPDATE"
}
```

### Paso 4: Guardar Cambios
1. Haz clic en **Guardar** o **Update**
2. Verifica que los campos se hayan guardado correctamente

## Verificación
Después de actualizar:
1. Ve a `/pacientes` en tu aplicación
2. Deberías poder acceder sin ser redirigido a la página de plan de suscripción

## Nota Técnica
El sistema usa `stripe_subscription_id` (con guión bajo) pero la clínica tenía `stripeSubscriptionId` (camelCase). Esta inconsistencia causaba que la validación fallara.

## Alternativa: Modificar el Código
Si prefieres, también puedes modificar el código para que busque `stripeSubscriptionId` en lugar de `stripe_subscription_id`, pero es mejor mantener la consistencia con el esquema de la base de datos.

