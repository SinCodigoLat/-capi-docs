# App Tracking Transparency - Implementación Mejorada

## Resumen de Cambios

Se ha mejorado la implementación de App Tracking Transparency (ATT) para cumplir con las directrices de Apple (5.1.2) y proporcionar una mejor experiencia de usuario.

## ¿Por qué pedimos el permiso ATT?

CAPI utiliza Firebase Analytics para recopilar datos de uso que nos ayudan a:

- Mejorar la experiencia de la aplicación
- Identificar y corregir errores
- Optimizar funcionalidades
- Personalizar recordatorios y notificaciones
- Medir el rendimiento de la app

**No compartimos datos con terceros para publicidad ni usamos el IDFA para rastreo con fines comerciales.**

## Ubicación del Permiso ATT

### 1. **Pantalla de Perfil del Usuario**

El usuario puede gestionar el permiso de tracking desde su perfil:

- **Ruta**: Menú lateral → Perfil → Sección "Preferencias" → "Privacidad y Analítica"
- **Visible**: Solo en iOS (se oculta automáticamente en Android/Web)
- **Estados**:
  - ✅ **Autorizado**: Muestra estado activo con opción de ver detalles
  - ⚠️ **No determinado**: Permite solicitar el permiso con diálogo educativo previo
  - ❌ **Denegado**: Ofrece ir directamente a Ajustes de iOS para habilitarlo

### 2. **Flujo de Usuario**

#### Caso A: Primera vez (No determinado)

1. Usuario toca "Privacidad y Analítica" en su perfil
2. Se muestra un diálogo educativo que explica:
   - Para qué usamos los datos
   - Qué beneficios obtiene el usuario
   - Garantía de privacidad (no compartimos con terceros)
3. Usuario elige "Permitir" o "No permitir"
4. Si elige "Permitir", se muestra el diálogo nativo de iOS
5. Se actualiza el estado en la UI

#### Caso B: Ya fue denegado

1. Usuario toca "Privacidad y Analítica" en su perfil
2. Se muestra un diálogo con instrucciones claras:
   - Cómo ir a Ajustes → Privacidad → Rastreo
   - Botón directo "Ir a Ajustes" que abre la configuración de iOS
3. Usuario puede habilitar el permiso desde Ajustes
4. Al regresar a la app, el estado se actualiza automáticamente

#### Caso C: Ya está autorizado

1. Usuario toca "Privacidad y Analítica" en su perfil
2. Se muestra un diálogo confirmando que el seguimiento está activo
3. Se ofrece opción de ir a Ajustes si desea deshabilitarlo

## Cambios Técnicos Implementados

### 1. `AppTrackingService` (`lib/services/app_tracking_service.dart`)

**Antes:**
- Solicitaba el permiso automáticamente al iniciar la app (mala UX)

**Ahora:**
- `initialize()`: Solo verifica el estado actual, NO solicita permiso
- `requestTrackingPermission()`: Método manual para solicitar el permiso cuando el usuario lo desee
- `openAppSettings()`: Abre directamente los ajustes de iOS
- `getTrackingStatus()`: Obtiene el estado actual del permiso

### 2. `main.dart` (`lib/main.dart`)

**Cambio:**
- Se mantiene la llamada a `AppTrackingService.initialize()` al inicio
- Ahora solo verifica el estado sin mostrar el diálogo nativo
- No interrumpe el flujo de inicio de la app

### 3. `PerfilWidget` (`lib/clinica/menu_principal/perfil/perfil_widget.dart`)

**Nuevo:**
- Agregada sección "Privacidad y Analítica" en preferencias (solo iOS)
- Muestra estado actual del permiso con indicadores visuales
- Maneja los tres casos: no determinado, denegado, autorizado
- Diálogos educativos antes de solicitar permiso
- Instrucciones claras para ir a ajustes

## Respuesta para Apple Review

### Guideline 2.1 - Information Needed

**Pregunta de Apple:**
> "Where can we find the App Tracking Transparency permission request in the app?"

**Respuesta:**

La solicitud de App Tracking Transparency se encuentra en la **pantalla de Perfil del usuario**, dentro de la sección de "Preferencias":

**Ruta de navegación:**
1. Abrir la app CAPI
2. Tocar el menú lateral (☰)
3. Seleccionar "Perfil"
4. Desplazarse a la sección "Preferencias"
5. Tocar "Privacidad y Analítica"

**Comportamiento:**
- Si es la primera vez, se muestra un diálogo educativo explicando el uso de datos
- Al aceptar, aparece el prompt nativo de iOS para autorizar el tracking
- Si el usuario ya negó el permiso, se le ofrecen instrucciones para habilitarlo en Ajustes

**Nota importante:**
- El permiso NO se solicita automáticamente al abrir la app por primera vez
- Damos control total al usuario sobre cuándo y cómo gestionar sus preferencias de privacidad
- Esto mejora la experiencia de usuario y aumenta la tasa de aceptación del permiso

**Por qué usamos tracking:**
Utilizamos Firebase Analytics únicamente para:
- Mejorar la experiencia de la app
- Detectar y corregir errores
- Optimizar funcionalidades clínicas
- NO usamos datos para publicidad ni los compartimos con terceros

## Testing

### Cómo probar en un dispositivo iOS:

1. **Primera instalación (Estado: No determinado)**
   - Instalar la app
   - Ir a Perfil → Preferencias → Privacidad y Analítica
   - Tocar la opción
   - Verificar que aparece el diálogo educativo
   - Aceptar y verificar que aparece el prompt nativo de iOS

2. **Permiso denegado**
   - Ir a Ajustes → Privacidad → Rastreo → CAPI → Desactivar
   - Abrir CAPI → Perfil → Preferencias → Privacidad y Analítica
   - Verificar que muestra estado "Deshabilitado"
   - Tocar y verificar que ofrece ir a Ajustes

3. **Permiso autorizado**
   - Ir a Ajustes → Privacidad → Rastreo → CAPI → Activar
   - Abrir CAPI → Perfil → Preferencias → Privacidad y Analítica
   - Verificar que muestra estado "Activo"

### Reset del estado para testing:

```bash
# Desinstalar la app del simulador/dispositivo
# O resetear permisos:
Settings → General → Reset → Reset Location & Privacy
```

## Archivo de Configuración

El texto del diálogo de permiso se configura en `Info.plist`:

```xml
<key>NSUserTrackingUsageDescription</key>
<string>Utilizamos datos de uso anónimos para mejorar la experiencia de CAPI, optimizar funcionalidades y personalizar recordatorios. No compartimos tus datos con terceros ni los usamos para publicidad.</string>
```

## Conclusión

Esta implementación:
✅ Cumple con las directrices de Apple (5.1.2)
✅ Proporciona control total al usuario
✅ Incluye diálogos educativos antes de solicitar permiso
✅ Ofrece rutas claras para gestionar el permiso después de negarlo
✅ Mejora significativamente la UX comparado con la solicitud automática

---

**Versión**: 2.0.0+6 (o superior)
**Fecha**: Noviembre 2025
**Plataforma**: iOS 14.0+





