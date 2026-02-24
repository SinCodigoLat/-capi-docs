---
layout: default
title: Integraciones
parent: Manual Técnico
nav_order: 7
---

# Integraciones

CAPI App se integra con múltiples servicios externos para proporcionar funcionalidades avanzadas.

## Stripe

### Suscripciones

Stripe maneja las suscripciones mensuales de las clínicas.

#### Flujo de Suscripción

1. Clínica selecciona plan (Starter, Premium, Elite)
2. App crea checkout session vía N8N
3. Usuario completa pago en Stripe
4. Webhook de Stripe notifica a N8N
5. N8N actualiza estado en Firestore
6. App sincroniza estado de suscripción

#### Configuración

```dart
// En app_constants.dart
static const String skLiveStripe = 'sk_live_...';
static const String pkLiveStripe = 'pk_live_...';
static const String planPrice01 = 'price_...'; // Starter
static const String planPrice02 = 'price_...'; // Premium
static const String planPrice03 = 'price_...'; // Elite
```

#### Validación de Suscripción

```dart
final isValid = await SubscriptionService.validateSubscription(
  subscriptionId: clinica.stripeSubscriptionId,
);
```

### Asignación Manual / Planes Ilimitados (Panel Admin)

Es posible asignar planes sin interactuar directamente con el flujo de compra, útil para:
- Otorgar un **Plan Ilimitado** u otros planes internos (isPublic = false).
- Planes con **Monto 0** (gratuitos).

Al asignar estos planes desde el Panel de Administrador:
1. Se actualiza el `planSuscripcion` en Firestore.
2. Se limpian los IDs previos de Stripe (`stripe_subscription_id`, `stripe_subscription_price_id`, `stripe_subscription_product_id`).
3. Se marca manualmente el status: `stripe_subscription_status = 'active'`, para que la App Móvil reconozca el servicio como vigente sin requerir verificación con Stripe.
4. **Importante:** Si la clínica poseía una suscripción pagada activa previamente, el administrador debe ir al Dashboard de Stripe para **cancelar el cobro iterativo manualmente**, dado que el Panel no hace la cancelación directa en la API por seguridad.

### Stripe Connect

Stripe Connect permite que pacientes paguen directamente a doctores.

#### Configuración

1. Crear cuenta Connect en Stripe
2. Obtener Client ID de Connect
3. Configurar redirect URLs
4. Implementar flujo de onboarding

#### Flujo de Pago

1. Paciente selecciona servicio de pago
2. App crea payment intent con Connect
3. Paciente completa pago
4. Stripe procesa y transfiere a doctor
5. Webhook actualiza estado en Firestore

## RevenueCat (iOS)

RevenueCat maneja las compras in-app para iOS usando StoreKit.

### Configuración

```dart
// En app_constants.dart
static const String revenueCatIosApiKeyProd = 'appl_...';
static const String revenueCatEntitlementIdentifier = 'suscripciones Capi';
static const String revenueCatOfferingIdentifier = 'default';
```

### Flujo de Compra iOS

1. Usuario selecciona plan en iOS
2. App llama a RevenueCat para obtener offerings
3. Usuario completa compra en App Store
4. RevenueCat valida compra
5. Webhook de RevenueCat actualiza Firestore
6. App sincroniza estado

### Validación de Suscripción iOS

```dart
final hasActive = await RevenueCatService.hasActiveSubscription(
  forceRefresh: true,
);
```

## Zoom

Zoom proporciona videoconsultas integradas.

### Configuración

1. Crear app en Zoom Marketplace
2. Obtener API Key y Secret
3. Configurar en clínica:
   ```dart
   clinica.zoom = ConfZoomStruct(
     apiKey: '...',
     apiSecret: '...',
   );
   ```

### Creación de Reuniones

```dart
final response = await ZoomCall.call(
  token: zoomToken,
  fechaCita: fecha,
  tituloCita: 'Consulta médica',
  anfitrion: doctorEmail,
  invitado: pacienteEmail,
);

final meetingUrl = ZoomCall.zoomLink(response);
```

### Enlaces Instantáneos

Las clínicas pueden configurar un enlace Zoom instantáneo que se usa para citas inmediatas.

## N8N

N8N automatiza workflows y webhooks.

### Workflows Principales

1. **Crear Checkout Stripe**
   - Crea customer y checkout session
   - URL: `/webhook/pagar-suscripcion`

2. **Procesar Pago Completado**
   - Procesa evento `checkout.session.completed`
   - Actualiza suscripción en Firestore
   - URL: `/webhook/stripe-webhook-completed`

3. **Emails Automáticos**
   - Verifica chats pendientes periódicamente
   - Envía emails de recordatorio

### Configuración de Webhooks

```javascript
// En N8N workflow
const webhookUrl = 'https://sincodigo-n8n.oawden.easypanel.host/webhook/...';
```

## Firebase Cloud Messaging

### Configuración

**Web:**
```javascript
// firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js');
```

**Android:**
- Configurar en `AndroidManifest.xml`
- Agregar `google-services.json`

**iOS:**
- Configurar en `Info.plist`
- Agregar capabilities

### Envío de Notificaciones

```dart
await NotificationService.sendNotification(
  token: fcmToken,
  title: 'Nueva cita',
  body: 'Tienes una cita programada',
  data: {'citaId': '...'},
);
```

## Google Places API

Para autocompletado de direcciones.

### Uso

```dart
final places = await PlacesCall.call(
  input: 'Calle...',
  apiKey: googlePlacesApiKey,
);
```

### Proxy en Cloud Functions

Las llamadas a Places API se hacen a través de Cloud Functions para proteger la API key.

## Algolia (Opcional)

Para búsqueda avanzada de doctores.

### Configuración

```dart
// En backend/algolia/
final algolia = AlgoliaManager.instance;
await algolia.search('doctor', index: 'users');
```

## Próximos Pasos

1. [Despliegue](./08-despliegue.md) - Build y despliegue
2. [Troubleshooting](./09-troubleshooting.md) - Problemas comunes

---

**Anterior:** [Autenticación y Roles ←](./06-autenticacion-roles.md) | **Siguiente:** [Despliegue →](./08-despliegue.md)

