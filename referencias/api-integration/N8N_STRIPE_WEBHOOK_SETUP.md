# 🔧 Configuración de Webhook de Stripe en N8N

## 📋 **Problema Actual**
- El workflow N8N crea checkout sessions correctamente
- **FALTA**: Procesar el evento `checkout.session.completed` cuando el pago se completa
- El usuario `oncologycarematamoros@gmail.com` se queda atrapado en validación

## 🎯 **Solución: Nuevo Workflow N8N**

### **Paso 1: Crear Nuevo Workflow en N8N**

1. **Ve a tu instancia N8N**: `https://sincodigo-n8n.oawden.easypanel.host/`
2. **Crea nuevo workflow**
3. **Importa el JSON**: Usa el archivo `N8N_WEBHOOK_STRIPE_COMPLETED.json`

### **Paso 2: Configurar Webhook en Stripe Dashboard**

1. **Ve a**: https://dashboard.stripe.com/webhooks
2. **Crea nuevo endpoint**:
   - **URL**: `https://sincodigo-n8n.oawden.easypanel.host/webhook/stripe-webhook-completed`
   - **Descripción**: `Capi - Process Checkout Completed`
3. **Selecciona eventos**:
   - ✅ `checkout.session.completed`
4. **Guarda el endpoint**

### **Paso 3: Configurar Webhook Secret**

1. **Copia el webhook secret** de Stripe (empieza con `whsec_`)
2. **En N8N**, ve a la configuración del webhook
3. **Agrega el secret** en la configuración de autenticación

### **Paso 4: Activar Workflow**

1. **Activa el workflow** en N8N
2. **Verifica que esté funcionando** con un test

## 🔄 **Flujo Completo**

### **Flujo Actual (Funcionando):**
```
Usuario → N8N Webhook → Crear Customer → Crear Checkout → Actualizar Clinica → Responder URL
```

### **Flujo Nuevo (Agregar):**
```
Stripe → N8N Webhook → Verificar Evento → Obtener Subscription → Actualizar Clinica → Responder
```

### **Flujo Completo (Resultado):**
```
1. Usuario inicia pago → N8N crea checkout → Usuario paga
2. Stripe envía evento → N8N procesa → Actualiza subscription_id
3. Usuario puede acceder normalmente
```

## 🧪 **Probar la Solución**

### **Test con Usuario Actual:**
1. El usuario `oncologycarematamoros@gmail.com` puede completar su pago pendiente
2. Stripe enviará el evento `checkout.session.completed`
3. N8N procesará el evento y actualizará la clínica
4. El usuario ya no se quedará atrapado en validación

### **Verificar en Firestore:**
- `stripe_subscription_id` se creará automáticamente
- `stripe_subscription_status` cambiará a `active`
- `stripe_plan_end_date` se establecerá correctamente

## 📊 **Monitoreo**

### **En N8N:**
- Revisa los logs del workflow
- Verifica que los eventos se procesen correctamente

### **En Stripe Dashboard:**
- Revisa los logs del webhook
- Verifica que los eventos se envíen correctamente

### **En Firebase Console:**
- Revisa los documentos de clínica actualizados
- Verifica que los campos se actualicen correctamente

## 🎉 **Resultado Esperado**

Una vez configurado:
- ✅ Procesamiento automático de pagos completados
- ✅ Actualización automática de suscripciones
- ✅ No más usuarios atrapados en validación
- ✅ Flujo completamente automatizado
- ✅ Integración perfecta con el workflow existente

## 🚨 **Solución de Problemas**

### **Si el webhook no funciona:**
1. Verificar que el workflow esté activo en N8N
2. Verificar que el webhook esté configurado correctamente en Stripe
3. Revisar logs en N8N y Stripe
4. Probar con un evento de test

### **Si la clínica no se actualiza:**
1. Verificar que el `clinicaId` esté en los metadata del checkout session
2. Verificar las credenciales de Firebase en N8N
3. Revisar los logs de N8N para errores

## 📝 **Notas Importantes**

- **No modificar** el workflow existente de creación de checkout
- **Agregar** el nuevo workflow para procesar eventos completados
- **Mantener** la misma estructura de datos en Firestore
- **Usar** las mismas credenciales de Stripe y Firebase


