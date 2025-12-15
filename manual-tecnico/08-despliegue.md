---
layout: default
title: Despliegue
parent: Manual Técnico
nav_order: 8
---

# Despliegue

Guía para construir y desplegar CAPI App en diferentes plataformas.

## Preparación

### Verificar Configuración

1. Verificar variables de entorno
2. Verificar credenciales de Firebase
3. Verificar configuración de servicios externos
4. Verificar versiones en `pubspec.yaml`

### Build de Producción

```bash
# Limpiar build anterior
flutter clean

# Obtener dependencias
flutter pub get

# Verificar que no hay errores
flutter analyze
```

## Android

### Configuración Pre-Build

1. **Verificar `android/app/build.gradle`:**
   ```gradle
   android {
       compileSdkVersion 33
       defaultConfig {
           applicationId "com.capi.app"
           minSdkVersion 21
           targetSdkVersion 33
           versionCode 1
           versionName "2.0.1"
       }
   }
   ```

2. **Verificar `google-services.json`** en `android/app/`

3. **Configurar signing config** para release

### Build APK

```bash
flutter build apk --release
```

El APK se genera en: `build/app/outputs/flutter-apk/app-release.apk`

### Build App Bundle (Recomendado)

```bash
flutter build appbundle --release
```

El AAB se genera en: `build/app/outputs/bundle/release/app-release.aab`

### Subir a Google Play

1. Ir a [Google Play Console](https://play.google.com/console)
2. Crear nueva release
3. Subir AAB
4. Completar información de release
5. Revisar y publicar

## iOS

### Configuración Pre-Build

1. **Abrir proyecto en Xcode:**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configurar signing:**
   - Seleccionar equipo de desarrollo
   - Configurar provisioning profiles

3. **Verificar `Info.plist`:**
   - Permisos de cámara, ubicación, notificaciones
   - URL schemes

4. **Verificar `GoogleService-Info.plist`**

### Build IPA

```bash
flutter build ipa --release
```

El IPA se genera en: `build/ios/ipa/`

### Subir a App Store Connect

1. Abrir Xcode
2. Product → Archive
3. Distribute App
4. Seleccionar App Store Connect
5. Subir build

### Configurar en App Store Connect

1. Ir a [App Store Connect](https://appstoreconnect.apple.com)
2. Crear nueva versión
3. Seleccionar build subido
4. Completar información
5. Enviar para revisión

## Web

### Build Web

```bash
flutter build web --release
```

Los archivos se generan en: `build/web/`

### Desplegar en Firebase Hosting

```bash
# Configurar Firebase
firebase init hosting

# Desplegar
firebase deploy --only hosting
```

### Configuración de Hosting

En `firebase.json`:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

### Variables de Entorno Web

Configurar en `web/index.html`:

```html
<script>
  window.env = {
    STRIPE_PUBLIC_KEY: 'pk_live_...',
    FIREBASE_API_KEY: '...',
    // ...
  };
</script>
```

## Cloud Functions

### Desplegar Functions

```bash
cd firebase/functions
npm install
cd ../..
firebase deploy --only functions
```

### Desplegar Function Específica

```bash
firebase deploy --only functions:sendNotification
```

## Firestore Rules

### Desplegar Rules

```bash
firebase deploy --only firestore:rules
```

### Verificar Rules

```bash
firebase firestore:rules:test
```

## Firestore Indexes

### Desplegar Indexes

```bash
firebase deploy --only firestore:indexes
```

## Configuración de Entornos

### Desarrollo

```bash
flutter run --dart-define=ENV=dev
```

### Staging

```bash
flutter build apk --dart-define=ENV=staging
```

### Producción

```bash
flutter build apk --dart-define=ENV=prod --release
```

## CI/CD (Opcional)

### GitHub Actions

Ejemplo de workflow:

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter build apk --release
```

## Verificación Post-Despliegue

1. Verificar que la app inicia correctamente
2. Verificar autenticación
3. Verificar notificaciones push
4. Verificar integraciones (Stripe, Zoom, etc.)
5. Verificar que no hay errores en consola

## Próximos Pasos

1. [Troubleshooting](./09-troubleshooting.md) - Problemas comunes

---

**Anterior:** [Integraciones ←](./07-integraciones.md) | **Siguiente:** [Troubleshooting →](./09-troubleshooting.md)

