# 🍎 Cumplimiento Apple Guideline 5.1.1(v) - Eliminación de Cuentas

**Fecha:** Diciembre 2024  
**Estado:** ✅ Implementado  
**Prioridad:** 🔴 Crítica - Requerido para aprobación en App Store  
**Responsable:** Equipo de Desarrollo CAPI

---

## 🎯 **OBJETIVO**

Implementar funcionalidad de eliminación de cuentas para cumplir con la **Guideline 5.1.1(v) de Apple** que requiere que las apps que soportan creación de cuentas también ofrezcan eliminación de cuentas.

---

## 📋 **REQUISITOS DE APPLE**

### **Guideline 5.1.1(v) - Data Collection and Storage**
- ✅ **Eliminación de cuenta obligatoria** para apps que soportan creación de cuentas
- ✅ **No solo desactivación temporal** - debe ser eliminación permanente
- ✅ **Acceso directo desde la app** - no requiere visitar sitio web externo
- ✅ **Confirmación para prevenir eliminación accidental**
- ✅ **Cumplimiento con normativas médicas** (COFEPRIS)

---

## 🚀 **IMPLEMENTACIÓN COMPLETADA**

### **1. Interfaz de Usuario**
**Archivo:** `lib/componentes/account_deletion/account_deletion_widget.dart`

#### **Características:**
- **Diseño visual distintivo** con colores de advertencia (rojo)
- **Advertencias claras** sobre pérdida de datos
- **Confirmaciones múltiples** para prevenir eliminación accidental
- **Campo de confirmación** que requiere escribir "ELIMINAR"
- **Advertencias legales** específicas para normativas médicas

#### **Flujo de Usuario:**
1. Usuario accede a Configuración → Sección "Zona de Peligro"
2. Lee advertencias sobre pérdida de datos
3. Confirma 3 checkboxes obligatorios:
   - ✅ Entiendo que esta acción es irreversible
   - ✅ Acepto que se perderán todos mis datos permanentemente
   - ✅ He leído y acepto las advertencias legales
4. Escribe "ELIMINAR" en el campo de confirmación
5. Presiona botón "Eliminar Cuenta Permanentemente"

### **2. Lógica de Eliminación**
**Funcionalidades implementadas:**

#### **Auditoría Completa:**
```dart
await FirebaseFirestore.instance.collection('audit_logs').add({
  'userId': user.uid,
  'action': 'ACCOUNT_DELETION',
  'timestamp': FieldValue.serverTimestamp(),
  'userEmail': user.email,
  'userRole': currentUserDocument?.role,
  'deletedBy': user.uid,
  'reason': 'User requested account deletion',
});
```

#### **Eliminación de Datos:**
- ✅ **Documento de usuario** en Firestore
- ✅ **Consultas médicas** del usuario
- ✅ **Conversaciones y chats** del usuario
- ✅ **Notificaciones** del usuario
- ✅ **Cuenta de Firebase Auth**

#### **Cumplimiento Legal:**
- ✅ **LFPDPPP Compliance** - Ley Federal de Protección de Datos
- ✅ **COFEPRIS Compliance** - Normativas médicas mexicanas
- ✅ **Auditoría completa** de la eliminación
- ✅ **Advertencias legales** específicas

### **3. Integración en Perfil de Usuario**
**Archivo:** `lib/clinica/menu_principal/perfil/perfil_widget.dart`

- ✅ **Import agregado** del componente
- ✅ **Ubicación:** Sección "Gestión de Cuenta" en Perfil
- ✅ **Posición:** Después del botón "Cerrar sesión"
- ✅ **Diseño visual distintivo** con diseño profesional y minimalista
- ✅ **Acceso directo** desde la app (no requiere sitio web externo)
- ✅ **Contexto apropiado** - En la pantalla de perfil donde se gestiona la información personal

---

## 🔒 **SEGURIDAD Y CUMPLIMIENTO**

### **Medidas de Seguridad:**
- **Confirmaciones múltiples** para prevenir eliminación accidental
- **Campo de confirmación** que requiere texto específico
- **Auditoría completa** de todas las eliminaciones
- **Manejo de errores** robusto con mensajes informativos

### **Cumplimiento Legal:**
- **LFPDPPP** - Ley Federal de Protección de Datos Personales
- **COFEPRIS** - Normativas médicas mexicanas
- **Apple Guidelines** - Cumplimiento completo con 5.1.1(v)
- **Advertencias legales** específicas para el sector médico

### **Retención de Datos Médicos:**
- **Nota importante:** Algunos datos médicos pueden requerir retención por normativas COFEPRIS
- **Auditoría completa** para cumplimiento regulatorio
- **Documentación** de todas las eliminaciones

---

## 📱 **EXPERIENCIA DE USUARIO**

### **Diseño Visual:**
- **Colores de advertencia** (rojo) para destacar la gravedad
- **Iconos de advertencia** para llamar la atención
- **Texto claro** sobre las consecuencias
- **Diseño responsivo** para móvil y web

### **Flujo de Confirmación:**
1. **Advertencias visuales** claras
2. **Lista de datos** que se perderán
3. **Checkboxes obligatorios** para confirmación
4. **Campo de texto** que requiere "ELIMINAR"
5. **Botón final** con confirmación visual

### **Mensajes de Estado:**
- **Loading state** durante eliminación
- **Mensajes de éxito** al completar
- **Mensajes de error** con detalles específicos
- **Redirección automática** al login

---

## 🧪 **TESTING Y VALIDACIÓN**

### **Casos de Prueba:**
- ✅ **Eliminación exitosa** con confirmaciones completas
- ✅ **Prevención de eliminación** sin confirmaciones
- ✅ **Manejo de errores** en eliminación de datos
- ✅ **Auditoría completa** de eliminaciones
- ✅ **Redirección** al login después de eliminación

### **Validación Apple:**
- ✅ **Acceso directo** desde la app
- ✅ **Eliminación permanente** (no solo desactivación)
- ✅ **Confirmación** para prevenir eliminación accidental
- ✅ **Cumplimiento** con normativas médicas

---

## 📊 **MÉTRICAS DE CUMPLIMIENTO**

### **Apple Guidelines:**
- ✅ **5.1.1(v) Compliance** - Eliminación de cuentas implementada
- ✅ **Acceso directo** - No requiere sitio web externo
- ✅ **Eliminación permanente** - No solo desactivación
- ✅ **Confirmación** - Previene eliminación accidental

### **Normativas Médicas:**
- ✅ **LFPDPPP Compliance** - Ley mexicana de protección de datos
- ✅ **COFEPRIS Compliance** - Normativas médicas
- ✅ **Auditoría completa** - Trazabilidad de eliminaciones
- ✅ **Advertencias legales** - Información clara al usuario

---

## 🚀 **DEPLOYMENT**

### **Archivos Implementados:**
1. **Componente de eliminación:** `lib/componentes/account_deletion/account_deletion_widget.dart`
2. **Página dedicada:** `lib/clinica/eliminar_cuenta/eliminar_cuenta_widget.dart`
3. **Perfil actualizado:** `lib/clinica/menu_principal/perfil/perfil_widget.dart`
4. **Rutas agregadas:** `lib/flutter_flow/nav/nav.dart` y `lib/index.dart`

### **Dependencias:**
- ✅ **Firebase Auth** - Para eliminación de cuenta
- ✅ **Cloud Firestore** - Para eliminación de datos
- ✅ **Flutter Flow** - Para UI components
- ✅ **Auditoría** - Para cumplimiento legal

### **Testing Requerido:**
- ✅ **Funcionalidad** - Eliminación completa de datos
- ✅ **UI/UX** - Flujo de confirmación
- ✅ **Seguridad** - Prevención de eliminación accidental
- ✅ **Legal** - Cumplimiento con normativas

---

## 🏥 **MANEJO DE CLÍNICAS EN ELIMINACIÓN DE CUENTA**

### **Flujo para Propietarios de Clínica**

Si el usuario es propietario (`owner_user`) de una clínica, se activa un flujo especial de eliminación:

#### **1. Detección Automática**
- El sistema verifica si el usuario es propietario de alguna clínica
- Se consulta la colección `clinica` buscando `owner_user == currentUser`
- Si se detecta ownership, se activa el flujo especial

#### **2. Advertencia Adicional**
Se muestra un diálogo específico indicando:
- **Nombre de la clínica** que será eliminada
- **Cantidad de usuarios afectados** (doctores, asistentes)
- **Acciones que se tomarán:**
  - Cancelación inmediata de suscripción Stripe
  - Notificación por email a todos los usuarios
  - Anonimización de datos médicos
  - Archivo de datos en `medical_data_archive`
  - Eliminación de clínica y datos relacionados

#### **3. Proceso de Eliminación de Clínica**

**A) Cancelación de Suscripción Stripe:**
```dart
// Cancelación inmediata (no al final del período)
DELETE https://api.stripe.com/v1/subscriptions/{subscriptionId}
Authorization: Bearer {stripeSKKey}
```

**B) Notificación a Usuarios:**
- Se envían emails a todos los usuarios de la clínica
- No se notifica al propietario (quien está eliminando)
- Email incluye:
  - Nombre de la clínica eliminada
  - Nombre del propietario
  - Fecha de eliminación
  - Información sobre acceso a datos personales
  - Contacto de soporte

**C) Anonimización de Datos Médicos (COFEPRIS):**
- Se procesan las siguientes colecciones:
  - `consulta` - Consultas médicas
  - `antecedentes` - Historial médico
  - `signosVitales` - Signos vitales
  - `exploracionFisica` - Exploración física
  - `diagnosticoTratamiento` - Diagnósticos y tratamientos
  - `cirugia` - Procedimientos quirúrgicos
  - `citas` - Agenda médica

- Campos anonimizados:
  - `paciente` → "ANONIMIZADO"
  - `doctor` → "ANONIMIZADO"
  - `nombres` → "ANONIMIZADO"
  - `apellidos` → "ANONIMIZADO"
  - `email` → "ANONIMIZADO@deleted.local"
  - `telefono` → "ANONIMIZADO"

- Se agrega metadata:
  - `deletedAt` → timestamp
  - `deletionReason` → "OWNER_ACCOUNT_DELETION"
  - `originalDocId` → ID del documento original

**D) Archivo de Auditoría:**
```dart
medical_data_archive/
  {archiveId}/
    - clinicId: string
    - archivedAt: timestamp
    - reason: "CLINIC_DELETION_BY_OWNER"
    - dataCount: number
    - collections: array<string>
    - anonymizedData: map<string, array>
    - retentionYears: 5  // Requerimiento COFEPRIS
```

**E) Eliminación de Datos de Clínica:**
- Se eliminan todos los documentos relacionados:
  - Consultas, antecedentes, signos vitales
  - Exploraciones físicas, diagnósticos, cirugías
  - Citas, servicios

**F) Actualización de Usuarios:**
- Se actualiza el campo `clinica` de todos los usuarios
- Se remueve la referencia a la clínica eliminada
- Los usuarios mantienen sus datos personales

**G) Eliminación del Documento de Clínica:**
- Finalmente, se elimina el documento principal de la clínica
- Esto incluye todos los datos de configuración y suscripción

### **Cumplimiento Normativo**

#### **COFEPRIS:**
- ✅ **Datos médicos anonimizados** - No se eliminan, se anonimizan
- ✅ **Archivo por 5 años** - Retención según normativa
- ✅ **Trazabilidad completa** - Auditoría de eliminación

#### **LFPDPPP:**
- ✅ **Derecho al olvido** - Con preservación legal requerida
- ✅ **Anonimización** - Cumple con protección de datos
- ✅ **Notificación** - Usuarios afectados son notificados

#### **Stripe:**
- ✅ **Cancelación inmediata** - No cobros posteriores
- ✅ **Sin período de gracia** - Cancelación efectiva inmediata

### **Archivos Relacionados**
- **Modelo:** `lib/models/clinic_ownership_info.dart`
- **Lógica:** `lib/componentes/account_deletion/account_deletion_widget.dart`
- **Métodos implementados:**
  - `_checkClinicOwnership()` - Verificar ownership
  - `_showClinicDeletionWarning()` - Diálogo de advertencia
  - `_cancelStripeSubscription()` - Cancelar suscripción
  - `_notifyClinicUsers()` - Notificar usuarios
  - `_sendClinicDeletionEmail()` - Enviar emails
  - `_anonymizeMedicalData()` - Anonimizar datos
  - `_deleteClinic()` - Eliminar clínica

### **Consideraciones Técnicas**

#### **Performance:**
- Operaciones masivas pueden tardar varios segundos
- Se muestran indicadores de carga apropiados
- Timeouts configurados para operaciones largas

#### **Manejo de Errores:**
- Errores en Stripe no bloquean la eliminación
- Errores en notificaciones se registran pero no detienen el proceso
- Error en eliminación de clínica SÍ detiene todo el proceso
- Logs detallados para diagnóstico

#### **Transaccionalidad:**
- No es posible transacción atómica (límite Firestore: 500 writes)
- Orden crítico de operaciones:
  1. Cancelar Stripe (puede fallar sin afectar resto)
  2. Notificar usuarios (puede fallar sin afectar resto)
  3. Anonimizar datos (crítico, debe completarse)
  4. Eliminar clínica (crítico, debe completarse)
  5. Eliminar usuario (final)

### **Testing de Flujo de Clínica**

**Pasos de prueba:**
1. Crear clínica de prueba con owner
2. Agregar 2-3 doctores/asistentes a la clínica
3. Crear datos médicos de prueba:
   - 5 consultas
   - 3 citas
   - Signos vitales y exploraciones
4. Configurar suscripción de Stripe de prueba
5. Ejecutar eliminación de cuenta del owner

**Verificaciones:**
- ✅ Email recibido por todos los usuarios (excepto owner)
- ✅ Suscripción Stripe cancelada en dashboard
- ✅ Datos en colección `medical_data_archive`
- ✅ Datos anonimizados correctamente
- ✅ Clínica eliminada de Firestore
- ✅ Usuarios actualizados (campo `clinica` removido)
- ✅ Cuenta owner eliminada de Firebase Auth
- ✅ Logs de auditoría registrados

---

## 📞 **SOPORTE Y MANTENIMIENTO**

### **Monitoreo:**
- **Auditoría logs** - Todas las eliminaciones registradas
- **Errores de eliminación** - Logs detallados
- **Métricas de uso** - Frecuencia de eliminaciones

### **Mantenimiento:**
- **Actualizaciones legales** - Cambios en normativas
- **Mejoras de UX** - Basadas en feedback de usuarios
- **Optimizaciones** - Performance de eliminación

---

## 🎉 **BENEFICIOS IMPLEMENTADOS**

### **Cumplimiento Apple:**
- ✅ **Guideline 5.1.1(v)** - Cumplimiento completo
- ✅ **Aprobación App Store** - Sin rechazos por eliminación de cuentas
- ✅ **Mejores prácticas** - Implementación robusta

### **Cumplimiento Legal:**
- ✅ **LFPDPPP** - Ley mexicana de protección de datos
- ✅ **COFEPRIS** - Normativas médicas
- ✅ **Auditoría completa** - Trazabilidad legal

### **Experiencia de Usuario:**
- ✅ **Transparencia** - Usuario entiende las consecuencias
- ✅ **Seguridad** - Prevención de eliminación accidental
- ✅ **Cumplimiento** - Cumple con normativas médicas

---

**Versión de la Implementación:** 3.0 - Gestión Completa de Clínicas  
**Fecha de implementación:** Diciembre 2024  
**Estado:** ✅ Completado y listo para producción  
**Cumplimiento Apple:** ✅ Guideline 5.1.1(v) - Account Deletion  
**Última actualización:** Octubre 2025 - Gestión de Clínicas, Stripe y COFEPRIS

---

*Esta implementación cumple completamente con los requisitos de Apple para eliminación de cuentas, incluyendo confirmaciones múltiples, advertencias legales específicas para el sector médico, y auditoría completa para cumplimiento con normativas COFEPRIS y LFPDPPP.*
