# RevenueCat – Webhook & Backend Sync (Draft)

Este documento describe el flujo propuesto para sincronizar las compras realizadas vía StoreKit/RevenueCat con los servicios existentes (Firestore + Stripe + N8N).

## 1. Objetivo
- Recibir eventos de RevenueCat (p. ej. `INITIAL_PURCHASE`, `RENEWAL`, `CANCELLATION`).
- Actualizar el estado de suscripción de la clínica en Firestore.
- Notificar a los servicios auxiliares (Stripe, N8N) para mantener métricas y automatizaciones.

## 2. Endpoint sugerido

```
POST https://<cloud-function>/revenuecat/webhook
```

### Validaciones:
1. Verificar `signature` enviada por RevenueCat (HMAC SHA256).
2. Asociar `app_user_id` con el documento `clinica/{clinicaId}`.
3. Mapear `entitlement` activo → plan (`Starter`, `Premium`, `Elite`).

## 3. Acciones por evento

| Evento RevenueCat | Acción sugerida |
| ----------------- | --------------- |
| `INITIAL_PURCHASE`, `RENEWAL` | Actualizar `nombrePlan`, `stripeSubscriptionStatus` = `active`, `limitePacientes`, `limitePersonal`, `creditsAi`. Registrar log en `audit_logs`. |
| `CANCELLATION`, `EXPIRATION` | Marcar plan como inactivo, conservar fecha fin period. Notificar a N8N para workflows de retención. |
| `BILLING_ISSUE` | Enviar alerta al propietario de la clínica y mantener plan activo durante el `grace period`. |

## 4. Pendientes (TODO)
1. Crear función en `firebase/functions` (`revenuecatWebhook.ts`) reutilizando utilidades existentes de Stripe.
2. Registrar endpoint en RevenueCat Dashboard (Production y Sandbox).
3. Agregar pruebas unitarias básicas (mock eventos) y smoke test en Staging.
4. Documentar proceso de verificación de firma en la función.

## 5. Referencias
- [RevenueCat Webhooks](https://www.revenuecat.com/docs/webhooks)
- `GestionPagoAPIGroup` (N8N) para reusar lógica de límites/AI credits.
- `lib/services/revenuecat_service.dart` para IDs de planes y entitlements.

> Nota: Este documento es un plan base. Actualizar una vez que la función esté implementada.***

