# 📁 Archivos Obsoletos y Redundantes

Este documento identifica archivos que pueden ser eliminados o consolidados para mantener el proyecto limpio.

## 🗑️ Archivos para Eliminar

### Documentos Redundantes
- `SOLUCION_ERROR_STRIPE_404.md` → Consolidado en `api-integration/SOLUCION_FINAL_N8N.md`
- `SOLUCION_WEBHOOK_FINAL.md` → Consolidado en `api-integration/SOLUCION_FINAL_N8N.md`
- `STRIPE_WEBHOOK_SETUP.md` → Consolidado en `api-integration/N8N_STRIPE_WEBHOOK_SETUP.md`

### Documentos de Testing Obsoletos
- `test_notification.js` → Eliminado (ya no se usa)
- `test_notifications_guide.md` → Consolidado en `features/INTEGRACION_NOTIFICACIONES_PUSH.md`
- `test_*.js` → Scripts de prueba obsoletos

### Archivos de Configuración Duplicados
- `firebase.json` → Eliminado (duplicado)
- `firebase.staging.json` → Mantener si se usa para staging

### Documentos de Optimización Completados
- `MENU_PACIENTE_OPTIMIZACION.md` → Ya completado, puede archivarse
- `MENU_PACIENTE_REFACTORIZACION_COMPLETADA.md` → Documento de estado, puede eliminarse

## 📋 Archivos para Consolidar

### Documentos de Sistema de Emails
- `SISTEMA_BACKUP_EMAIL_CHAT_README.md` → Consolidar con `SISTEMA_EMAILS_CHAT_PERIODICO_README.md`
- `SISTEMA_EMAILS_CHAT_PERIODICO_README.md` → Ya organizado en `features/`

### Documentos de Notificaciones
- `INTEGRACION_NOTIFICACIONES_PUSH.md` → Ya organizado en `features/`
- `SISTEMA_PERMISOS_NOTIFICACIONES.md` → Consolidar con notificaciones principales

### Documentos de N8N
- `N8N_STRIPE_WEBHOOK_SETUP.md` → Ya organizado en `api-integration/`
- `N8N_WORKFLOW_MEJORADO.json` → Archivo de configuración, mantener en raíz
- `N8N_WEBHOOK_STRIPE_COMPLETED.json` → Archivo de configuración, mantener en raíz

## 🧹 Archivos de Limpieza

### Scripts de Limpieza
- `cleanup_duplicate_tokens.js` → Script ejecutable, mantener en raíz
- `CLEANUP_TOKENS_README.md` → Ya organizado en `development/`

### Archivos de Migración
- `FCM_TOKENS_MIGRATION_README.md` → Ya organizado en `development/`

## 📊 Resumen de Acciones

### ✅ Ya Organizados en `/docs`
- `INTEGRACION_NOTIFICACIONES_PUSH.md` → `features/`
- `SOLUCION_FINAL_N8N.md` → `api-integration/`
- `IMPLEMENTACION_PAGINACION_ORDENAMIENTO.md` → `features/`
- `CAMPOS_AUDITORIA_IMPLEMENTACION.md` → `architecture/`
- `SCRIPTS_README.md` → `development/`
- `TODO.md` → `development/`
- `Cumplimiento_normas.md` → `security/`
- `SISTEMA_EMAILS_CHAT_PERIODICO_README.md` → `features/`
- `INSTRUCCIONES_*.md` → `development/`
- `MENU_PACIENTE_*.md` → `features/`

### 🗑️ Para Eliminar
- Documentos redundantes de soluciones
- Scripts de prueba obsoletos
- Documentos de estado completados
- Archivos de configuración duplicados

### 📁 Para Mantener en Raíz
- Archivos de configuración JSON (N8N, Firebase)
- Scripts ejecutables
- Archivos de configuración del proyecto
- `README.md` principal del proyecto

## 🎯 Próximos Pasos

1. **Eliminar archivos obsoletos** identificados
2. **Consolidar documentos redundantes**
3. **Actualizar referencias** en código si es necesario
4. **Mantener estructura limpia** en `/docs`

## 📝 Notas

- Los archivos JSON de configuración deben mantenerse en la raíz
- Los scripts ejecutables deben mantenerse en la raíz
- Solo mover documentación a `/docs`
- Mantener enlaces funcionales entre documentos




