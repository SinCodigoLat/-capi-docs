# 📧 Sistema de Emails Periódicos para Chats Pendientes

## 🎯 **Objetivo**

Implementar un sistema automatizado que verifique periódicamente los chats pendientes y envíe emails de notificación a través de N8N cuando un mensaje no haya sido visto en un tiempo determinado.

## 🏗️ **Arquitectura del Sistema**

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Cloud Function│────│   Firebase       │────│   N8N Webhook   │────│   Resend API    │
│ (cada 5 min)    │    │   Firestore      │    │                 │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📋 **Componentes**

### **1. Cloud Function: `chatEmailPeriodicCheck`**

**Ubicación**: `firebase/functions/chat_email_periodic_check.js`

**Características**:
- **Frecuencia**: Cada 5 minutos (`*/5 * * * *`)
- **Timezone**: Europe/Madrid
- **Memoria**: 512MiB
- **Timeout**: 300 segundos (5 minutos)

**Funcionalidad**:
1. Consulta chats con mensajes de los últimos 15 minutos
2. Filtra chats pendientes según criterios inteligentes
3. Envía datos al webhook de N8N
4. Maneja cache para evitar emails duplicados

### **2. Webhook N8N**

**URL**: `https://sincodigo-n8n.oawden.easypanel.host/webhook/capi_chat_pendiente`

**Flujo**:
1. Recibe datos de la Cloud Function
2. Procesa plantillas de email según prioridad
3. Envía email via Resend API
4. Retorna resultado a Cloud Function

### **3. Criterios de Verificación**

#### **Tiempo Mínimo**: 15+ minutos pendiente
```javascript
if (tiempoPendiente < 15) {
  // No enviar email
}
```

#### **Verificación de Visto**: No todos han visto el mensaje
```javascript
const todosHanVisto = users.every(userRef => 
  lastMessageSeenBy.some(seenRef => 
    seenRef.id === userRef.id
  )
);
```

#### **Cache de Emails**: Evitar duplicados
```javascript
const tiempoDesdeUltimoEmail = Math.floor((ahora - ultimoEmail) / (1000 * 60));
if (tiempoDesdeUltimoEmail < 30) { // 30 minutos entre emails
  // No enviar email
}
```

## 🚀 **Despliegue**

### **Paso 1: Desplegar Cloud Function**
```bash
./deploy_chat_email_function.sh
```

### **Paso 2: Verificar en Firebase Console**
- Ir a Firebase Console → Functions
- Verificar que `chatEmailPeriodicCheck` esté activa
- Revisar configuración de schedule

### **Paso 3: Monitorear Logs**
```bash
firebase functions:log --only chatEmailPeriodicCheck
```

## 📊 **Estructura de Datos**

### **Input de la Cloud Function**
```javascript
{
  event: 'chat_pendiente_periodico',
  timestamp: '2024-01-15T14:30:00Z',
  data: {
    chat_id: 'chat_123456',
    usuario: {
      id: 'user_789',
      nombre: 'Juan Pérez',
      email: 'juan@email.com',
      telefono: '+34 600 123 456',
      tipo: 'paciente'
    },
    remitente: {
      id: 'user_456',
      nombre: 'Dr. García',
      tipo: 'doctor'
    },
    chat: {
      ultimo_mensaje: {
        texto: 'Hola doctor, tengo una pregunta',
        timestamp: '2024-01-15T14:15:00Z',
        enviado_por: 'usuario'
      },
      estado: 'pendiente',
      tiempo_pendiente: '15 minutos',
      tiempo_pendiente_num: 15,
      prioridad: 'normal',
      tipo_conversacion: 'uno_a_uno',
      total_usuarios: 2,
      usuarios_pendientes: 1
    },
    equipo: [
      {
        id: 'doc_123',
        nombre: 'Dr. García',
        email: 'doctor@doctorcapi.com',
        rol: 'doctor',
        especialidad: 'Medicina General'
      }
    ],
    contexto: {
      consulta_relacionada: 'cons_123456',
      fecha_consulta: '2024-01-20T10:00:00Z',
      motivo_consulta: 'Consulta de seguimiento'
    }
  }
}
```

### **Tipos de Conversación Soportados**

| Tipo | Descripción | Ejemplo | Funciona |
|------|-------------|---------|----------|
| `uno_a_uno` | 2 usuarios | Doctor ↔ Paciente | ✅ |
| `equipo_cliente` | 3 usuarios | Doctor + Asistente ↔ Paciente | ✅ |
| `grupal` | 4+ usuarios | Equipo completo ↔ Cliente | ✅ |

### **Escenarios Específicos**

#### **Doctor-Paciente (1:1)**
```json
{
  "tipo_conversacion": "uno_a_uno",
  "total_usuarios": 2,
  "usuarios_pendientes": 1
}
```

#### **Equipo-Cliente (1:N)**
```json
{
  "tipo_conversacion": "equipo_cliente", 
  "total_usuarios": 3,
  "usuarios_pendientes": 1
}
```

#### **Conversación Grupal (N:N)**
```json
{
  "tipo_conversacion": "grupal",
  "total_usuarios": 5,
  "usuarios_pendientes": 2
}
```

### **Prioridades de Email**

| Tiempo Pendiente | Prioridad | Acción |
|------------------|-----------|--------|
| 15-29 minutos    | Normal    | Email estándar |
| 30-59 minutos    | Urgente   | Email con urgencia |
| 60+ minutos      | Crítica   | Email con alta prioridad |

## 🔍 **Testing**

### **Script de Prueba**
```bash
node test_cloud_function_chat_email.js
```

### **Ejecución Manual**
```bash
firebase functions:shell
chatEmailPeriodicCheck()
```

### **Verificar Webhook**
```bash
curl -X POST https://sincodigo-n8n.oawden.easypanel.host/webhook/capi_chat_pendiente \
  -H "Content-Type: application/json" \
  -d '{
    "event": "chat_pendiente_periodico",
    "data": {
      "chat_id": "test_123",
      "usuario": {
        "email": "test@email.com",
        "nombre": "Usuario Test"
      }
    }
  }'
```

## 📈 **Monitoreo**

### **Métricas Importantes**
- Total chats procesados por ejecución
- Emails enviados vs fallidos
- Distribución por prioridad
- Tiempo de ejecución de la función

### **Logs de Ejemplo**

#### **Escenario Doctor-Paciente (1:1)**
```
🕐 Verificación periódica de chats pendientes iniciada: 2024-01-15T14:30:00Z
📅 Buscando chats con mensajes desde: 2024-01-15T14:15:00Z
📊 Total chats encontrados: 25
🔍 Procesando chat chat_123:
   ⏰ Tiempo pendiente: 20 minutos
📋 Chat chat_123: 2 usuarios total, 1 han visto, 1 pendientes
✅ Chat pendiente detectado (normal)
📧 Enviando email para chat chat_123 a juan@email.com
✅ Email enviado para chat chat_123
```

#### **Escenario Equipo-Cliente (1:N)**
```
🔍 Procesando chat chat_456:
   ⏰ Tiempo pendiente: 45 minutos
📋 Chat chat_456: 3 usuarios total, 2 han visto, 1 pendientes
✅ Chat pendiente detectado (urgente)
📧 Enviando email para chat chat_456 a maria@email.com
✅ Email enviado para chat chat_456
```

#### **Escenario Todos Han Visto**
```
🔍 Procesando chat chat_789:
   ⏰ Tiempo pendiente: 5 minutos
👁️ Chat chat_789: todos han visto el mensaje
```

#### **Resumen Final**
```
📊 Resumen de verificación periódica: {
  total_chats_procesados: 25,
  emails_enviados: 2,
  emails_fallidos: 0,
  distribucion_prioridad: { normal: 1, urgente: 1, critica: 0 }
}
```

## ⚙️ **Configuración Avanzada**

### **Ajustar Frecuencia**
```javascript
// En chat_email_periodic_check.js
schedule: '*/10 * * * *', // Cambiar a cada 10 minutos
```

### **Ajustar Criterios de Tiempo**
```javascript
// Tiempo mínimo para enviar email
if (tiempoPendiente < 20) { // Cambiar de 15 a 20 minutos
  return null;
}

// Tiempo entre emails
if (tiempoDesdeUltimoEmail < 45) { // Cambiar de 30 a 45 minutos
  return null;
}
```

### **Ajustar Límite de Chats**
```javascript
.limit(100) // Cambiar de 50 a 100 chats por ejecución
```

## 🔧 **Troubleshooting**

### **Problema: Función no se ejecuta**
```bash
# Verificar estado de la función
firebase functions:list

# Verificar logs
firebase functions:log --only chatEmailPeriodicCheck
```

### **Problema: Emails duplicados**
- Verificar cache en memoria de la función
- Ajustar tiempo entre emails
- Revisar lógica de `lastMessageSeenBy`

### **Problema: Webhook no responde**
- Verificar URL del webhook
- Revisar logs de N8N
- Probar webhook manualmente

## 📝 **Próximos Pasos**

1. **Monitorear en Producción**: Observar comportamiento durante primeros días
2. **Optimizar Criterios**: Ajustar tiempos según feedback de usuarios
3. **Agregar Métricas**: Implementar dashboard de monitoreo
4. **Escalar**: Considerar aumentar frecuencia si es necesario
5. **Personalización**: Permitir configuración por usuario/clínica

## 🎉 **Beneficios del Sistema**

- ✅ **Confiabilidad**: No depende del cliente Flutter
- ✅ **Escalabilidad**: Maneja todos los chats automáticamente
- ✅ **Inteligencia**: Criterios sofisticados para evitar spam
- ✅ **Monitoreo**: Logs detallados y métricas
- ✅ **Flexibilidad**: Fácil ajuste de parámetros
- ✅ **Integración**: Aprovecha infraestructura existente (Firebase + N8N)
