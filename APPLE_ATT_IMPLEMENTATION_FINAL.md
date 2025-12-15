# App Tracking Transparency - Implementación Final

**Fecha:** 19 de Noviembre 2025  
**Estado:** ✅ Implementado  
**Cumple con:** Directriz 5.1.2 de Apple

---

## Resumen

CAPI implementa App Tracking Transparency (ATT) cumpliendo completamente con las directrices de Apple:

1. ✅ La solicitud de permiso ATT aparece **ANTES** de recopilar cualquier dato
2. ✅ Firebase Analytics está **DESHABILITADO** hasta obtener el permiso
3. ✅ El usuario ve el diálogo nativo de iOS al iniciar la app (primera vez)
4. ✅ El tracking solo se habilita si el usuario otorga el permiso

---

## Flujo de Implementación

### 1. Al Iniciar la App (Primera Vez)

```
Usuario abre CAPI
    ↓
[iOS] AppTrackingService.requestATTPermission()
    ↓
Verificar estado ATT
    ↓
¿Es primera vez? (notDetermined)
    ↓ SÍ
Mostrar diálogo nativo de iOS:
"CAPI utiliza datos de uso para mejorar la experiencia..."
    ↓
Usuario elige: "Permitir" o "No permitir"
    ↓
Guardar decisión del usuario
    ↓
Firebase.initializeApp()
    ↓
AppTrackingService.initializeAnalytics()
    ↓
Si PERMITIR → Firebase Analytics: HABILITADO
Si NO PERMITIR → Firebase Analytics: DESHABILITADO
    ↓
App carga normalmente
```

### 2. Inicios Posteriores

```
Usuario abre CAPI
    ↓
[iOS] AppTrackingService.requestATTPermission()
    ↓
Verificar estado ATT guardado
    ↓
NO se muestra diálogo (ya fue respondido)
    ↓
Firebase.initializeApp()
    ↓
AppTrackingService.initializeAnalytics()
    ↓
Si AUTORIZADO → Firebase Analytics: HABILITADO
Si DENEGADO → Firebase Analytics: DESHABILITADO
    ↓
App carga normalmente
```

---

## Detalles Técnicos

### Archivos Modificados

#### 1. `lib/services/app_tracking_service.dart`

**Cambios clave:**
- Separación en dos fases: `requestATTPermission()` y `initializeAnalytics()`
- `requestATTPermission()` solicita ATT **SIN** tocar Firebase (evita error "no-app")
- `initializeAnalytics()` configura Analytics **DESPUÉS** de Firebase.initializeApp()
- Solo habilita Analytics si el permiso es `TrackingStatus.authorized`

```dart
// FASE 1: Solicitar ATT (ANTES de Firebase)
static Future<void> requestATTPermission() async {
    if (Platform.isIOS) {
        final status = await AppTrackingTransparency.trackingAuthorizationStatus;
        if (status == TrackingStatus.notDetermined) {
            final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
            _trackingEnabled = newStatus == TrackingStatus.authorized;
        } else {
            _trackingEnabled = status == TrackingStatus.authorized;
        }
    }
}

// FASE 2: Configurar Analytics (DESPUÉS de Firebase)
static Future<void> initializeAnalytics() async {
    _analytics = FirebaseAnalytics.instance;
    if (Platform.isIOS) {
        await _analytics!.setAnalyticsCollectionEnabled(_trackingEnabled);
    }
}
```

#### 2. `lib/main.dart`

**Cambios clave:**
- `requestATTPermission()` se llama **ANTES** de `initFirebase()`
- `initializeAnalytics()` se llama **DESPUÉS** de `initFirebase()`
- Orden crítico: ATT → Firebase → Analytics

```dart
// PASO 1: Solicitar ATT (ANTES de Firebase)
if (!kIsWeb) {
    await AppTrackingService.requestATTPermission();
}

// PASO 2: Inicializar Firebase
await initFirebase();

// PASO 3: Configurar Analytics con el permiso ATT ya obtenido
if (!kIsWeb) {
    await AppTrackingService.initializeAnalytics();
}
```

#### 3. `ios/Runner/GoogleService-Info.plist`

**Configuración:**
```xml
<key>IS_ANALYTICS_ENABLED</key>
<false></false>
```

Analytics deshabilitado por defecto en la configuración de Firebase.

#### 4. `ios/Runner/Info.plist`

**Mensaje del permiso ATT:**
```xml
<key>NSUserTrackingUsageDescription</key>
<string>CAPI utiliza datos de uso para mejorar la experiencia de la app, optimizar funcionalidades clínicas y personalizar recordatorios médicos. No compartimos tus datos con terceros ni los usamos para publicidad.</string>
```

---

## Gestión Manual desde la UI

El usuario también puede gestionar el permiso desde:

**Ruta:** Perfil → Preferencias → Privacidad y Analítica

Estados:
- ✅ **Autorizado:** Analytics habilitado
- ⚠️ **No determinado:** Puede solicitar permiso
- ❌ **Denegado:** Analytics deshabilitado, puede ir a Ajustes de iOS

---

## ¿Por Qué Usamos Tracking?

CAPI utiliza Firebase Analytics exclusivamente para:

1. 📊 **Mejorar la experiencia:** Identificar funcionalidades más útiles
2. 🐛 **Identificar errores:** Detectar y corregir problemas
3. ⚡ **Optimizar rendimiento:** Medir velocidad y fluidez
4. 🔔 **Personalizar recordatorios:** Mejorar notificaciones médicas
5. 📈 **Medir uso:** Entender cómo los médicos y pacientes usan la app

**NO usamos los datos para:**
- ❌ Publicidad de terceros
- ❌ Vender datos a brokers
- ❌ Rastreo con fines comerciales
- ❌ Compartir con anunciantes

---

## Respuesta para Apple Review

### Dónde encontrar la solicitud ATT:

**Opción 1: Automática (Primera vez)**
1. Instalar la app en un dispositivo iOS/iPadOS limpio (o resetear permisos)
2. Abrir la app CAPI
3. Al iniciar, INMEDIATAMENTE aparece el diálogo de ATT:
   - Título: "Allow "Doctor Capi" to track your activity across other companies' apps and websites?"
   - Descripción: Nuestro mensaje del `NSUserTrackingUsageDescription`
   - Opciones: "Allow" / "Ask App Not to Track"

**Opción 2: Manual (Desde Perfil)**
1. Abrir CAPI
2. Menú → Perfil
3. Sección "Preferencias"
4. Tocar "Privacidad y Analítica"
5. Gestionar permiso o ir a Ajustes de iOS

### Cuándo aparece:

La solicitud aparece **ANTES** de:
- ✅ Inicializar Firebase
- ✅ Recopilar datos de Analytics
- ✅ Rastrear cualquier evento
- ✅ Cargar la pantalla principal

### Implementación técnica:

- **Framework:** `app_tracking_transparency: ^2.0.6+1`
- **Plataforma:** iOS 14.5+, iPadOS 14.5+
- **Control:** Programático mediante `AppTrackingTransparency.requestTrackingAuthorization()`
- **Firebase Analytics:** Deshabilitado por defecto, solo se habilita si se otorga el permiso

---

## Testing

### Cómo probar en iPad:

1. **Resetear permisos ATT:**
   - Ajustes → General → Transferir o Restablecer iPad → Restablecer → Restablecer ubicación y privacidad
   - O usar un iPad limpio con TestFlight

2. **Instalar build de prueba:**
   - Usar TestFlight con el build más reciente

3. **Verificar diálogo ATT:**
   - Abrir la app
   - El diálogo ATT debe aparecer INMEDIATAMENTE al iniciar
   - Antes de ver cualquier pantalla de la app

4. **Verificar Analytics:**
   - Si se permite → Analytics habilitado (logs en consola)
   - Si se deniega → Analytics deshabilitado (logs indican "evento no registrado")

### Logs de depuración:

```
📱 [DEBUG] Solicitando permiso ATT...
📱 AppTrackingService: Solicitando permiso ATT...
[Diálogo nativo de iOS aparece aquí]
📱 AppTrackingService: Permiso ATT - authorized (Tracking: true)
🔥 [DEBUG] Inicializando Firebase...
Firebase inicializado correctamente
📊 [DEBUG] Configurando Firebase Analytics...
📱 AppTrackingService: Firebase Analytics configurado en iOS (HABILITADO)
```

**Si el usuario deniega:**
```
📱 [DEBUG] Solicitando permiso ATT...
📱 AppTrackingService: Solicitando permiso ATT...
[Usuario elige "Ask App Not to Track"]
📱 AppTrackingService: Permiso ATT - denied (Tracking: false)
🔥 [DEBUG] Inicializando Firebase...
Firebase inicializado correctamente
📊 [DEBUG] Configurando Firebase Analytics...
📱 AppTrackingService: Firebase Analytics configurado en iOS (DESHABILITADO)
```

---

## Cumplimiento con Apple

✅ **Directriz 5.1.2 (Privacidad - Data Use and Sharing):**
- Solicitud ATT implementada correctamente
- Aparece antes de recopilar datos
- Usuario puede aceptar o rechazar
- Analytics solo funciona con permiso

✅ **Directriz 2.1 (App Completeness):**
- La solicitud es visible en iPadOS
- Funciona en iPad y iPhone
- Mensaje claro y descriptivo

✅ **Directriz 5.1.1 (Data Collection and Storage):**
- Información de privacidad actualizada en App Store Connect
- Aviso de Privacidad disponible en la app
- Usuario informado del uso de datos

---

## Notas Adicionales

### Si el usuario deniega el permiso:

- La app funciona **normalmente**
- Solo se deshabilita Firebase Analytics
- No afecta funcionalidades core (consultas, chat, citas, etc.)
- El usuario puede cambiar su decisión en Ajustes de iOS

### Si Apple pregunta dónde está ATT:

> "La solicitud de App Tracking Transparency aparece automáticamente al iniciar la aplicación en iOS/iPadOS (primera vez que se abre). Se solicita ANTES de inicializar Firebase o recopilar cualquier dato. La implementación está en `lib/services/app_tracking_service.dart` y se llama desde `lib/main.dart` antes de `initFirebase()`. Firebase Analytics está deshabilitado por defecto y solo se habilita si el usuario otorga el permiso."

---

## Recursos

- [Apple - App Tracking Transparency](https://developer.apple.com/documentation/apptrackingtransparency)
- [App Store Review Guidelines 5.1.2](https://developer.apple.com/app-store/review/guidelines/#data-collection-and-storage)
- [Firebase Analytics - iOS](https://firebase.google.com/docs/analytics/get-started?platform=ios)
- [Package: app_tracking_transparency](https://pub.dev/packages/app_tracking_transparency)

