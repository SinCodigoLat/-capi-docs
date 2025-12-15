# 🧹 Sistema de Limpieza de Tokens FCM Duplicados

Este sistema resuelve el problema de notificaciones push duplicadas causadas por múltiples tokens FCM del mismo dispositivo.

## 🎯 **PROBLEMA RESUELTO**

- **Antes**: Usuarios recibían múltiples notificaciones push por el mismo mensaje
- **Causa**: Múltiples tokens FCM registrados para el mismo dispositivo
- **Solución**: Mantener solo 1 token activo por dispositivo, eliminar duplicados

## 🚀 **CLOUD FUNCTIONS DISPONIBLES**

### 1. **cleanupDuplicateTokens** - Limpieza masiva
**URL**: `https://us-central1-capideveloper-6078c.cloudfunctions.net/cleanupDuplicateTokens`

**Descripción**: Limpia tokens duplicados para TODOS los usuarios del sistema.

**Uso**:
```bash
curl -X POST https://us-central1-capideveloper-6078c.cloudfunctions.net/cleanupDuplicateTokens
```

**Respuesta**:
```json
{
  "status": "success",
  "message": "Limpieza de tokens duplicados completada",
  "summary": {
    "totalUsers": 333,
    "processedUsers": 10,
    "totalTokens": 26,
    "cleanedTokens": 0,
    "activeTokens": 20,
    "durationMs": 9419
  },
  "userResults": [...]
}
```

### 2. **cleanupUserTokens** - Limpieza específica
**URL**: `https://us-central1-capideveloper-6078c.cloudfunctions.net/cleanupUserTokens`

**Descripción**: Limpia tokens duplicados para un usuario específico.

**Uso**:
```bash
curl -X POST https://us-central1-capideveloper-6078c.cloudfunctions.net/cleanupUserTokens \
  -H "Content-Type: application/json" \
  -d '{"userId": "kUIRa9lQhlPrZVjKOYAEbfeUoDS2"}'
```

**Respuesta**:
```json
{
  "status": "success",
  "message": "Limpieza de tokens completada",
  "summary": {
    "totalTokens": 7,
    "cleanedTokens": 6,
    "activeTokens": 1
  }
}
```

### 3. **scheduledCleanupTokens** - Limpieza automática
**Descripción**: Se ejecuta automáticamente cada domingo a las 2:00 AM UTC.

**Características**:
- ✅ Limpieza automática semanal
- ✅ Notificación a administradores
- ✅ Logs detallados
- ✅ Manejo de errores

## 🔧 **CÓMO FUNCIONA**

### **Identificación de Dispositivos**
Cada dispositivo genera un `deviceId` único basado en:
- **Web**: User Agent + Platform + Screen + Timezone
- **Android**: Device ID + Fingerprint
- **iOS**: Identifier for Vendor

### **Lógica de Limpieza**
1. **Agrupar tokens por `deviceId`**
2. **Por cada dispositivo**:
   - Si tiene 1 token → Verificar si está activo
   - Si tiene múltiples tokens → Mantener el más reciente, marcar otros como inválidos

### **Resultado**
- ✅ **1 token activo por dispositivo**
- ✅ **Múltiples dispositivos permitidos** (teléfono, tablet, computadora)
- ✅ **Sin notificaciones duplicadas**

## 📊 **ESTADÍSTICAS DE LA ÚLTIMA EJECUCIÓN**

```
📊 Resumen:
   - Usuarios procesados: 10/333
   - Tokens totales: 26
   - Tokens limpiados: 0
   - Tokens activos: 20
   - Duración: 9.4 segundos
```

## 🎯 **CASOS DE USO**

### **Limpieza Inmediata**
```bash
# Limpiar todos los usuarios
curl -X POST https://us-central1-capideveloper-6078c.cloudfunctions.net/cleanupDuplicateTokens
```

### **Limpieza de Usuario Específico**
```bash
# Limpiar usuario específico
curl -X POST https://us-central1-capideveloper-6078c.cloudfunctions.net/cleanupUserTokens \
  -H "Content-Type: application/json" \
  -d '{"userId": "USER_ID_AQUI"}'
```

### **Monitoreo**
- Revisar logs en Firebase Console
- Verificar notificaciones a administradores
- Monitorear métricas de notificaciones

## 🔍 **VERIFICACIÓN**

### **Antes de la limpieza**:
- Usuario recibe 7 notificaciones push por mensaje
- 7 tokens registrados para el mismo dispositivo

### **Después de la limpieza**:
- Usuario recibe 1 notificación push por mensaje
- 1 token activo por dispositivo
- Múltiples dispositivos siguen funcionando

## 🚨 **IMPORTANTE**

- ✅ **No afecta tokens de diferentes dispositivos**
- ✅ **Mantiene funcionalidad de múltiples dispositivos**
- ✅ **Solo elimina duplicados del mismo dispositivo**
- ✅ **Preserva el token más reciente**

## 📝 **LOGS Y MONITOREO**

### **Logs de la función**:
```
🧹 Iniciando limpieza de tokens duplicados...
📊 Procesando 333 usuarios...
👤 Procesando usuario: jorge-paciente@mail.com
   📱 7 tokens encontrados
   🔧 Dispositivo web_124664841: 4 tokens (limpiando duplicados)
   ✅ Usuario procesado: 6 limpiados, 1 activos
✅ Limpieza completada en 9419ms
```

### **Notificaciones a administradores**:
- Se envían solo si se limpiaron tokens
- Incluyen estadísticas de la limpieza
- Se envían a usuarios con `isAdmin: true`

## 🔄 **MANTENIMIENTO**

### **Limpieza automática**:
- **Frecuencia**: Cada domingo a las 2:00 AM UTC
- **Duración**: ~10-30 segundos
- **Alcance**: Todos los usuarios activos

### **Limpieza manual**:
- **Cuándo**: Cuando se reporten notificaciones duplicadas
- **Frecuencia**: Según necesidad
- **Alcance**: Usuarios específicos o todos

## 🎉 **RESULTADO FINAL**

- ✅ **Notificaciones push sin duplicados**
- ✅ **Soporte para múltiples dispositivos**
- ✅ **Limpieza automática semanal**
- ✅ **Monitoreo y alertas**
- ✅ **Sistema escalable y eficiente**

---

**Desarrollado por**: Equipo Capi  
**Fecha**: Septiembre 2025  
**Versión**: 1.0.0
