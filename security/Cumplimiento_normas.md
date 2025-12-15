Perfecto. Aquí tienes la división clara y luego un **plan de acción** con prioridades para implementar lo que falta en el sistema CAPI:

## ❌ FUNCIONES QUE **NO ESTÁN IMPLEMENTADAS**

### **A. Funciones clínicas**

- Consentimiento informado (documento, firma, registro)
- Egreso hospitalario (nota de egreso, resumen)

### **B. Seguridad y cumplimiento**

- Permisos no aplicados (estructura no usada en lógica)
- Firebase Rules demasiado básicas
- Falta de auditoría (sin `modifiedBy`, `actionType`, etc.)
- No hay validación de clínica por cada acción
- Sin logs ni dashboard de auditoría

### **C. Retención y backups**

- Sin backup automático
- Sin políticas de retención (5 años)
- Sin exportación automática a GCS
- Sin procedimientos de recuperación

### **D. Cumplimiento LFPDPPP**

- Aviso de privacidad incompleto (placeholder)
- No hay consentimiento informado en el flujo de usuario
- No existen mecanismos de derechos ARCO (acceso, rectificación, cancelación, oposición)
- No hay portabilidad de datos personales

---

## 🛠️ PLAN DE ACCIÓN

### 🔴 **Fase 1 – Urgente (1-2 semanas)**

1. **Aplicar lógica de permisos (`PermisosStruct`)** en todas las vistas y acciones
2. **Actualizar reglas de Firestore** para validar roles y pertenencia a clínica
3. **Reemplazar política de privacidad placeholder** con una redactada legalmente
4. **Añadir consentimiento informado en el registro** con checkbox + timestamp
5. **Iniciar sistema de auditoría** (mínimo: `modifiedBy`, `modifiedDate`, `actionType`)
6. **Configurar backups automáticos en Firestore**

### 🟡 **Fase 2 – Corto plazo (3-4 semanas)**

1. **Desarrollar funcionalidad para notas de egreso hospitalario**
2. **Crear documento digital de consentimiento informado** (con firma o check legal)
3. **Implementar formulario de derechos ARCO** (acceso, rectificación, cancelación)
4. **Crear colección y dashboard de logs de acceso/modificación**
5. **Exportación mensual automática a Google Cloud Storage**

### 🔵 **Fase 3 – Mediano plazo (2-3 meses)**

1. **Sistema completo de egreso hospitalario (resumen clínico, cierre de expediente)**
2. **Sistema de gestión ARCO con trazabilidad y notificación**
3. **Reportes automáticos de cumplimiento**
4. **Procedimientos documentados de recuperación**
5. **Auditoría de logs con IP, user agent y alertas de acceso sospechoso**

---