# 🔌 API Integration - Integraciones

Esta carpeta contiene documentación de integraciones con servicios externos y APIs.

## 📋 Integraciones Documentadas

### 🔗 [Solución N8N Final](./SOLUCION_FINAL_N8N.md)
**Estado**: ✅ Implementado
- Webhook de Stripe con N8N
- Procesamiento de pagos completados
- Actualización automática de Firestore
- Flujo completo de suscripciones

### ⚙️ [Setup Webhook Stripe](./N8N_STRIPE_WEBHOOK_SETUP.md)
**Estado**: ✅ Configurado
- Configuración de webhooks en Stripe
- Workflows N8N para pagos
- Integración con Firebase
- Monitoreo y troubleshooting

### ✅ [Estado Webhook](./WEBHOOK_READY.md)
**Estado**: ✅ Funcionando
- Estado actual de webhooks
- URLs y endpoints
- Configuración de seguridad
- Métricas de funcionamiento

## 🔄 Flujo de Integración

### Proceso de Pago
```
Usuario → Flutter App → N8N Webhook → Stripe Checkout → Usuario paga
Stripe → N8N Webhook → Procesar Evento → Actualizar Firestore
```

### Servicios Integrados
- **Stripe**: Procesamiento de pagos
- **N8N**: Automatización de workflows
- **Firebase**: Base de datos y autenticación
- **Resend**: Envío de emails

## 🛠️ Configuración

### URLs de Webhooks
- **Crear Checkout**: `https://sincodigo-n8n.oawden.easypanel.host/webhook/pagar-suscripcion`
- **Procesar Pago**: `https://sincodigo-n8n.oawden.easypanel.host/webhook/stripe-webhook-completed`
- **Chat Pendiente**: `https://sincodigo-n8n.oawden.easypanel.host/webhook/capi_chat_pendiente`

### Configuración en Stripe
1. Crear endpoint webhook
2. Configurar eventos: `checkout.session.completed`
3. Copiar webhook secret
4. Configurar en N8N

## 🧪 Testing

### Probar Webhooks
```bash
# Test de pago
curl -X POST https://sincodigo-n8n.oawden.easypanel.host/webhook/stripe-webhook-completed \
  -H "Content-Type: application/json" \
  -d '{"event": "test"}'
```

### Verificar Estado
1. Revisar logs en N8N
2. Verificar webhooks en Stripe Dashboard
3. Comprobar actualizaciones en Firestore

## 🔧 Troubleshooting

### Problemas Comunes
1. **Webhook no responde**: Verificar URL y configuración
2. **Pago no se procesa**: Revisar logs de N8N
3. **Datos no se actualizan**: Verificar credenciales de Firebase

### Logs Importantes
- N8N execution logs
- Stripe webhook logs
- Firebase function logs
- Flutter app console

## 📊 Monitoreo

### Métricas Clave
- Tasa de éxito de webhooks
- Tiempo de procesamiento
- Errores por tipo
- Volumen de transacciones

### Alertas Configuradas
- Fallos de webhook
- Errores de procesamiento
- Timeouts de funciones
- Problemas de conectividad




