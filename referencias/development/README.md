# 🔧 Development - Desarrollo

Esta carpeta contiene documentación para desarrolladores y configuración del entorno de desarrollo.

## 📋 Documentación Disponible

### 🚀 [Scripts de Desarrollo](./SCRIPTS_README.md)
**Estado**: ✅ Actualizado
- Scripts para ejecutar la aplicación
- Configuración web optimizada
- Solución de problemas comunes
- Comandos de mantenimiento

### 📝 [Instrucciones de Configuración](./INSTRUCCIONES_*.md)
**Estado**: ✅ Completas
- [Crear Doctor Test](./INSTRUCCIONES_CREAR_DOCTOR_TEST.md)
- [Avanzar Etapa](./INSTRUCCIONES_AVANZAR_ETAPA.md)
- [Actualizar Usuario](./INSTRUCCIONES_ACTUALIZAR_USUARIO.md)
- [Activar Suscripción](./INSTRUCCIONES_ACTIVAR_SUSCRIPCION.md)
- [Fix Suscripción](./INSTRUCCIONES_FIX_SUSCRIPCION.md)

### ✅ [TODO y Tareas](./TODO.md)
**Estado**: 🔄 En progreso
- Lista de tareas pendientes
- Mejoras del sidebar
- Funcionalidades faltantes
- Plan de acción por prioridades

### 🧹 [Cleanup y Migración](./CLEANUP_*.md)
**Estado**: ✅ Disponible
- [Cleanup Tokens](./CLEANUP_TOKENS_README.md)
- Scripts de migración
- Limpieza de datos duplicados

## 🛠️ Configuración del Entorno

### Requisitos Previos
- Flutter SDK (versión estable)
- Firebase CLI
- Node.js (para Cloud Functions)
- Git

### Pasos de Configuración
1. Clonar el repositorio
2. Ejecutar `flutter pub get`
3. Configurar Firebase
4. Usar scripts de desarrollo

### Scripts Principales
```bash
# Arranque completo (primera vez)
./run_web.sh

# Desarrollo diario
./run_web_dev.sh

# Limpieza y reinstalación
flutter clean && flutter pub get
```

## 🎯 Guías por Tarea

### Configurar Proyecto Nuevo
1. Leer [Scripts de Desarrollo](./SCRIPTS_README.md)
2. Seguir [Instrucciones de Configuración](./INSTRUCCIONES_*.md)
3. Verificar [TODO](./TODO.md) para tareas pendientes

### Desarrollo Diario
1. Usar `./run_web_dev.sh` para desarrollo rápido
2. Consultar troubleshooting en scripts
3. Mantener documentación actualizada

### Resolución de Problemas
1. Consultar [Troubleshooting](./SCRIPTS_README.md#solución-de-problemas)
2. Revisar logs de Firebase
3. Verificar configuración de dependencias

## 📚 Recursos Adicionales

### Documentación Externa
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFlow Documentation](https://docs.flutterflow.io/)

### Herramientas de Desarrollo
- Firebase Console
- Flutter Inspector
- Chrome DevTools
- N8N Dashboard

## 🔄 Mantenimiento

### Actualizar Dependencias
```bash
flutter pub upgrade
```

### Limpiar Proyecto
```bash
flutter clean
flutter pub get
```

### Verificar Estado
```bash
flutter doctor
firebase --version
```




