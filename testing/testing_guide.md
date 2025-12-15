# 🧪 Guía de Pruebas - Sistema de Lectura de Mensajes (ESTRATEGIA HÍBRIDA)

## 🚀 Nueva Estrategia Implementada

### **Estrategia Híbrida de Marcado de Mensajes:**

✅ **Auto-marcado por chat abierto** - Se marca automáticamente si el usuario tiene el chat abierto ✅ **Marcado por interacción** - Se marca cuando el usuario escribe en el TextField ✅ **Marcado por focus** - Se marca cuando el usuario enfoca/toca el TextField

## 📋 Pasos para Probar el Sistema

### **Preparación**

1. **Reinicia la aplicación** completamente
2. Abre la **consola de debugging** para ver los logs
3. Ten **dos dispositivos o cuentas** listas para probar

### **Prueba 1: Usuario Receptor con Chat Cerrado**

1. **Usuario A**: Envía un mensaje
2. **Usuario B**: NO abrir el chat todavía
3. **Verificar en consola**:
   ```
   ✅ Chat [ID] marcado como ABIERTO para usuario [USER_A]
   🔄 Auto-marcando mensaje como leído para usuario [USER_A]
   ```
4. **Resultado esperado**: Solo Usuario A debe estar en `last_message_seen_by`

### **Prueba 2: Usuario Receptor Abre Chat**

1. **Usuario B**: Abrir el chat
2. **Verificar en consola**:
   ```
   ✅ Chat [ID] marcado como ABIERTO para usuario [USER_B]
   🔍 Verificación inmediata - Chat está ABIERTO
   ```
3. **Verificar widget de debugging**: Estado debe mostrar "ABIERTO"
4. **Resultado esperado**: Usuario B se debe marcar automáticamente como leído

### **Prueba 3: Usuario Receptor con Chat Abierto**

1. **Usuario B**: Mantener chat abierto
2. **Usuario A**: Enviar otro mensaje
3. **Verificar en consola del Usuario B**:
   ```
   🔍 Verificando auto-marcado para usuario [USER_B] en chat [ID]
   ✅ Usuario [USER_B] tiene el chat [ID] abierto
   🔄 Auto-marcando mensaje como leído para usuario [USER_B]
   ✅ Mensaje marcado como leído exitosamente
   ```
4. **Resultado esperado**: Usuario B se marca automáticamente sin intervención

### **Prueba 4: Múltiples Usuarios**

1. **Usuario C**: Unirse al chat grupal
2. **Usuario A**: Enviar mensaje con B y C abiertos
3. **Verificar**: Todos los usuarios con chat abierto se marcan automáticamente

### **Prueba 5: Estrategia Híbrida - Marcado por Interacción**

1. **Usuario A**: Enviar mensaje
2. **Usuario B**: Tener chat CERRADO (no abrir)
3. **Usuario B**: Escribir en el TextField del chat (sin abrirlo)
4. **Verificar en consola**:
   ```
   🎯 Marcando mensaje como leído por interacción del usuario [USER_B]
   ✅ Mensaje marcado como leído por interacción del usuario [USER_B]
   ```
5. **Resultado esperado**: Usuario B se marca como leído por escribir

### **Prueba 6: Estrategia Híbrida - Marcado por Focus**

1. **Usuario A**: Enviar mensaje
2. **Usuario B**: Tener chat CERRADO (no abrir)
3. **Usuario B**: Tocar/enfocar el TextField del chat
4. **Verificar en consola**:
   ```
   🎯 Marcando mensaje como leído por focus del usuario [USER_B]
   ✅ Mensaje marcado como leído por focus del usuario [USER_B]
   ```
5. **Resultado esperado**: Usuario B se marca como leído por focus

### **Prueba 7: Combinación de Estrategias**

1. **Usuario A**: Enviar mensaje
2. **Usuario B**: Tener chat ABIERTO
3. **Usuario C**: Tener chat CERRADO pero escribir en TextField
4. **Verificar**:
   - Usuario B se marca automáticamente (chat abierto)
   - Usuario C se marca por interacción (escribir)
5. **Resultado esperado**: Ambos usuarios aparecen en `last_message_seen_by`

## 🔍 Qué Buscar en los Logs

### **Logs Esperados al Abrir Chat**

```
🎯 Chat [ID] marcado como abierto para usuario [USER_ID]
🔍 Verificación inmediata - Chat está ABIERTO
📊 Chats abiertos actuales: {chat_id: {user_id}}
```

### **Logs Esperados al Enviar Mensaje**

```
Lista de usuarios que han visto el mensaje preparada: [USER_IDS]
🔍 Verificando auto-marcado para usuario [USER_ID] en chat [ID]
✅ Usuario [USER_ID] tiene el chat [ID] abierto
🔄 Auto-marcando mensaje como leído para usuario [USER_ID]
✅ Mensaje marcado como leído exitosamente
```

### **Logs Esperados al Cerrar Chat**

```
❌ Chat [ID] marcado como CERRADO para usuario [USER_ID]
📊 Chats abiertos actuales: {}
```

### **Logs Esperados - Estrategia Híbrida**

#### **Marcado por Interacción (Escribir):**

```
🎯 Marcando mensaje como leído por interacción del usuario [USER_ID]
✅ Mensaje marcado como leído por interacción del usuario [USER_ID]
```

#### **Marcado por Focus (Tocar):**

```
🎯 Marcando mensaje como leído por focus del usuario [USER_ID]
✅ Mensaje marcado como leído por focus del usuario [USER_ID]
```

#### **Combinación de Estrategias:**

```
🆕 NUEVO mensaje - Lista inicializada SOLO con remitente: [USER_A]
🚀 Iniciando auto-marcado para usuarios con chat abierto...
✅ Usuario [USER_B] marcado automáticamente como leído
🎯 Marcando mensaje como leído por interacción del usuario [USER_C]
✅ Mensaje marcado como leído por interacción del usuario [USER_C]
📋 Lista final de usuarios que han visto el mensaje: [USER_A, USER_B, USER_C]
```

## 🚨 Problemas Comunes y Soluciones

### **Problema: "Usuario no autenticado"**

- **Causa**: `currentUserReference` es null
- **Solución**: Esperar a que el usuario esté completamente autenticado
- **Log esperado**: `❌ No se pudo registrar chat como abierto`

### **Problema: "Chat no se marca como abierto"**

- **Verificar**: Widget de debugging muestra "CERRADO"
- **Causa**: initState no se ejecutó correctamente
- **Solución**: Reiniciar la app y verificar los logs de inicialización

### **Problema: "Usuario no se marca automáticamente"**

- **Verificar**: Logs muestran `❌ Usuario NO tiene el chat abierto`
- **Causa**: Timing entre detección de mensaje y registro de chat
- **Solución**: El usuario debe abrir el chat antes de recibir el mensaje

### **Problema: "Mensaje se marca varias veces"**

- **Verificar**: Logs muestran `ℹ️ Usuario ya vio este mensaje`
- **Causa**: Sistema funcionando correctamente, evita duplicados

## 📊 Widget de Debugging

El widget naranja en la parte inferior del chat muestra:

- **Estado actual**: ABIERTO/CERRADO
- **Chat ID**: Identificador del chat
- **User ID**: Identificador del usuario
- **Último mensaje**: Preview del último mensaje
- **Estado de lectura**: SÍ/NO si el usuario actual lo ha leído
- **Estadísticas**: Número de chats tracked y usuarios online

## ✅ Criterios de Éxito

1. **Chat se registra como abierto** al entrar
2. **Chat se registra como cerrado** al salir
3. **Usuarios con chat abierto** se marcan automáticamente
4. **Usuarios con chat cerrado** NO se marcan automáticamente
5. **No hay duplicados** en `last_message_seen_by`
6. **Estado se preserva** entre mensajes
7. **Widget de debugging** muestra estado correcto

## 🛠️ Comandos de Debugging

Agregar estos comandos en la consola para debugging adicional:

```dart
// Ver estado actual del tracker
final tracker = ChatTrackerService();
print(tracker.getTrackingStats());

// Verificar si un chat está abierto
print(tracker.isChatOpenForUser('CHAT_ID', 'USER_ID'));

// Limpiar tracking (para testing)
tracker.clearAllTracking();
```

## 📝 Notas Importantes

- El widget de debugging es **temporal** y debe removerse en producción
- Los logs de emoji son para **facilitar la identificación** durante las pruebas
- El sistema es **resiliente a errores** y no crashea si falla alguna operación
- **Flutter hot reload** puede interferir con el tracking, usar hot restart para pruebas críticas
