# 📱 PLAN DE CUMPLIMIENTO APPLE - PRIVACIDAD Y TRACKING

**Fecha:** Diciembre 2024  
**Estado:** Pendiente de implementación  
**Prioridad:** 🔴 Crítica - Requerido para aprobación en App Store  
**Responsable:** Equipo de Desarrollo CAPI

---

## 🎯 **OBJETIVO**

Resolver los rechazos de Apple relacionados con:
- **Directriz 5.1.2**: App Tracking Transparency (ATT)
- **Directriz 5.1.1**: Cuenta de Organización para apps médicas

**Meta:** Obtener aprobación en App Store sin rechazos adicionales.

---

## 📋 **SITUACIÓN ACTUAL**

### **Problemas identificados por Apple:**

1. **App recopila datos de usuarios** (nombre, email, teléfono, ubicación, datos de salud)
2. **No implementa App Tracking Transparency** para solicitar permiso
3. **Cuenta individual** en lugar de organización (requerido para apps médicas)
4. **Información de privacidad** puede estar desactualizada en App Store Connect

### **Impacto en el negocio:**
- ❌ App rechazada en App Store
- ❌ No se puede publicar actualizaciones
- ❌ Pérdida de ingresos por retrasos
- ❌ Riesgo de reputación

---

## 🚀 **PLAN DE ACCIÓN - 3 FASES**

### **FASE 1: CUMPLIMIENTO TÉCNICO (Semana 1)**

#### **1.1 Implementar App Tracking Transparency**
**¿Qué hacemos?**
- Agregar solicitud de permiso al usuario antes de recopilar datos
- Mostrar mensaje claro sobre qué datos usamos y para qué
- Permitir al usuario aceptar o rechazar el tracking

**¿Por qué?**
- Apple lo requiere obligatoriamente desde iOS 14.5
- Sin esto, la app será rechazada automáticamente
- Es la forma de Apple de proteger la privacidad del usuario

**Resultado esperado:**
- Usuario ve popup de permiso al abrir la app
- Puede elegir si permite o no el tracking
- App funciona igual independientemente de la decisión

#### **1.2 Actualizar Política de Privacidad**
**¿Qué hacemos?**
- Reemplazar el texto placeholder (Lorem ipsum) con política real
- Incluir información específica sobre datos médicos
- Explicar claramente qué datos recopilamos y para qué

**¿Por qué?**
- Apple revisa que la política sea real y completa
- Los usuarios necesitan saber qué datos compartimos
- Es requerimiento legal para apps médicas

**Resultado esperado:**
- Política clara y específica para Doctor Capi
- Usuarios entienden qué datos compartimos
- Cumple con normativas legales

#### **1.3 Sistema de Consentimiento Médico**
**¿Qué hacemos?**
- Crear pantalla donde el usuario acepta específicamente el uso de datos médicos
- Diferentes opciones para diferentes tipos de datos
- Registro de cuándo y qué aceptó el usuario

**¿Por qué?**
- Los datos de salud son especialmente sensibles
- COFEPRIS requiere consentimiento específico
- Mejora la confianza del usuario

**Resultado esperado:**
- Usuario acepta conscientemente el uso de sus datos médicos
- Tenemos registro legal del consentimiento
- Cumple con normativas COFEPRIS

---

### **FASE 2: CUENTA DE ORGANIZACIÓN (Semana 2)**

#### **2.1 Crear Cuenta de Organización en Apple Developer**
**¿Qué hacemos?**
- Inscribirnos como organización en lugar de cuenta individual
- Proporcionar documentación legal de la empresa
- Verificar identidad del representante legal

**¿Por qué?**
- Apple requiere cuentas de organización para apps médicas
- Da mayor credibilidad y confianza
- Permite acceso a funciones empresariales

**Resultado esperado:**
- Cuenta de organización activa y verificada
- Acceso a herramientas empresariales de Apple
- Cumple con requisitos de Apple para apps médicas

#### **2.2 Transferir Aplicación**
**¿Qué hacemos?**
- Mover la app desde cuenta individual a organización
- Actualizar todos los certificados y perfiles
- Verificar que todo funcione correctamente

**¿Por qué?**
- La app debe estar bajo la cuenta correcta
- Evita problemas de certificados
- Permite envío desde cuenta autorizada

**Resultado esperado:**
- App transferida exitosamente
- Todos los certificados actualizados
- Lista para envío desde cuenta correcta

---

### **FASE 3: ENVÍO Y APROBACIÓN (Semana 3)**

#### **3.1 Actualizar Información en App Store Connect**
**¿Qué hacemos?**
- Revisar y actualizar información de privacidad
- Asegurar que coincida con lo implementado en la app
- Preparar documentación de cumplimiento

**¿Por qué?**
- La información debe ser consistente
- Apple verifica que todo coincida
- Evita confusión y rechazos

**Resultado esperado:**
- Información actualizada y consistente
- Documentación completa para Apple
- Lista para envío

#### **3.2 Envío a Apple con Documentación**
**¿Qué hacemos?**
- Enviar la app actualizada
- Incluir notas detalladas sobre los cambios
- Explicar dónde está implementado el ATT

**¿Por qué?**
- Apple necesita saber qué cambios hicimos
- Facilita el proceso de revisión
- Demuestra que cumplimos con los requisitos

**Resultado esperado:**
- App enviada con documentación completa
- Apple puede verificar fácilmente los cambios
- Mayor probabilidad de aprobación

---

## 📊 **CRONOGRAMA DETALLADO**

### **Semana 1: Implementación Técnica**
- **Día 1-2**: App Tracking Transparency
- **Día 3-4**: Política de privacidad real
- **Día 5**: Sistema de consentimiento médico

### **Semana 2: Cuenta de Organización**
- **Día 1-2**: Crear cuenta de organización
- **Día 3-4**: Transferir aplicación
- **Día 5**: Verificar certificados

### **Semana 3: Envío y Aprobación**
- **Día 1-2**: Actualizar App Store Connect
- **Día 3-4**: Envío a Apple
- **Día 5**: Seguimiento y correcciones

---

## 🎯 **CRITERIOS DE ÉXITO**

### **Técnicos:**
- ✅ App Tracking Transparency implementado
- ✅ Política de privacidad real y completa
- ✅ Sistema de consentimiento médico funcional
- ✅ Cuenta de organización activa

### **Legales:**
- ✅ Cumple con directrices de Apple
- ✅ Cumple con normativas COFEPRIS
- ✅ Documentación legal completa
- ✅ Consentimiento del usuario registrado

### **Negocio:**
- ✅ App aprobada en App Store
- ✅ Sin rechazos adicionales
- ✅ Usuarios pueden descargar actualizaciones
- ✅ Cumplimiento legal completo

---

## ⚠️ **RIESGOS Y MITIGACIONES**

### **Riesgo 1: Rechazo de Apple**
- **Problema**: Apple puede rechazar si no implementamos correctamente
- **Mitigación**: Seguir exactamente las directrices de Apple
- **Contingencia**: Revisar feedback y corregir rápidamente

### **Riesgo 2: Retraso en Cuenta de Organización**
- **Problema**: Proceso de verificación puede tomar tiempo
- **Mitigación**: Iniciar proceso inmediatamente
- **Contingencia**: Tener documentación lista de antemano

### **Riesgo 3: Problemas Técnicos**
- **Problema**: Implementación puede tener bugs
- **Mitigación**: Testing exhaustivo antes del envío
- **Contingencia**: Plan de rollback y corrección rápida

---

## 📞 **RESPONSABILIDADES**

### **Equipo de Desarrollo:**
- Implementar App Tracking Transparency
- Crear sistema de consentimiento
- Actualizar política de privacidad
- Testing y verificación

### **Equipo Legal:**
- Revisar política de privacidad
- Verificar cumplimiento COFEPRIS
- Preparar documentación legal

### **Equipo de Negocio:**
- Crear cuenta de organización
- Gestionar transferencia de app
- Comunicación con Apple

---

## 📈 **MÉTRICAS DE SEGUIMIENTO**

### **Semana 1:**
- [ ] ATT implementado y funcionando
- [ ] Política de privacidad actualizada
- [ ] Consentimiento médico funcional

### **Semana 2:**
- [ ] Cuenta de organización creada
- [ ] App transferida exitosamente
- [ ] Certificados actualizados

### **Semana 3:**
- [ ] App Store Connect actualizado
- [ ] App enviada a Apple
- [ ] Documentación completa

---

## 🎉 **BENEFICIOS ESPERADOS**

### **Inmediatos:**
- ✅ App aprobada en App Store
- ✅ Cumplimiento legal completo
- ✅ Sin rechazos adicionales

### **A largo plazo:**
- ✅ Mayor confianza de los usuarios
- ✅ Cumplimiento con normativas
- ✅ Base sólida para futuras actualizaciones
- ✅ Mejor reputación en el mercado

---

**Versión del Plan:** 1.0  
**Fecha de creación:** Diciembre 2024  
**Próxima revisión:** Después de implementación  
**Estado:** Listo para ejecución

---

*Este plan define los pasos necesarios para resolver los rechazos de Apple y obtener la aprobación de Doctor Capi en App Store, cumpliendo con todas las directrices de privacidad y tracking.*
