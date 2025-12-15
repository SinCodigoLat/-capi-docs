---
layout: default
title: Instalación y Configuración
parent: Manual Técnico
nav_order: 3
---

# Instalación y Configuración

## Requisitos Previos

### Software Necesario

1. **Flutter SDK** (3.0.0 o superior)
   ```bash
   flutter --version
   ```

2. **Dart SDK** (incluido con Flutter)
   ```bash
   dart --version
   ```

3. **Firebase CLI**
   ```bash
   npm install -g firebase-tools
   firebase --version
   ```

4. **Git**
   ```bash
   git --version
   ```

5. **Node.js** (18+ para Cloud Functions)
   ```bash
   node --version
   ```

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/SinCodigoLat/capi-app.git
cd Capi-App
```

### 2. Instalar Dependencias de Flutter

```bash
flutter pub get
```

### 3. Configurar Firebase

#### Opción A: Usando FlutterFire CLI

```bash
flutterfire configure
```

Esto te guiará para:
- Seleccionar plataformas (iOS, Android, Web)
- Seleccionar proyecto Firebase
- Configurar archivos de configuración

#### Opción B: Configuración Manual

1. **Android:** Copiar `google-services.json` a `android/app/`
2. **iOS:** Configurar `GoogleService-Info.plist` en Xcode
3. **Web:** Configurar en `web/index.html`

### 4. Configurar Variables de Entorno

Crear archivo `.env` en la raíz del proyecto:

```env
# Stripe
STRIPE_PUBLIC_KEY=pk_live_...
STRIPE_SECRET_KEY=sk_live_...

# Zoom
ZOOM_API_KEY=...
ZOOM_API_SECRET=...

# RevenueCat (iOS)
REVENUECAT_API_KEY=...

# N8N
N8N_WEBHOOK_URL=https://...
```

### 5. Configurar Cloud Functions

```bash
cd firebase/functions
npm install
```

### 6. Configurar Firebase Emulators (Opcional)

```bash
firebase init emulators
```

## Configuración por Plataforma

### Android

1. **Configurar `android/app/build.gradle`:**
   ```gradle
   android {
       compileSdkVersion 33
       // ...
   }
   ```

2. **Verificar `google-services.json`** en `android/app/`

3. **Configurar permisos** en `AndroidManifest.xml`

### iOS

1. **Abrir proyecto en Xcode:**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configurar `GoogleService-Info.plist`**

3. **Configurar Capabilities:**
   - Push Notifications
   - Background Modes

4. **Configurar Info.plist** con permisos necesarios

### Web

1. **Configurar Firebase en `web/index.html`**

2. **Configurar `firebase-messaging-sw.js`** para notificaciones

3. **Verificar CORS** en Firebase Console

## Configuración de Servicios Externos

### Stripe

1. Crear cuenta en [Stripe](https://stripe.com)
2. Obtener API keys (Test y Live)
3. Configurar webhooks en Stripe Dashboard
4. Agregar webhook URL de N8N

### Zoom

1. Crear app en [Zoom Marketplace](https://marketplace.zoom.us)
2. Obtener API Key y Secret
3. Configurar redirect URLs
4. Agregar credenciales en Firebase

### RevenueCat (iOS)

1. Crear cuenta en [RevenueCat](https://www.revenuecat.com)
2. Configurar App Store Connect
3. Crear productos y offerings
4. Configurar webhooks

### N8N

1. Configurar instancia de N8N
2. Crear workflows necesarios
3. Configurar webhooks
4. Agregar URLs en variables de entorno

## Verificación de Instalación

### Ejecutar en Desarrollo

**Web:**
```bash
flutter run -d chrome
```

**Android:**
```bash
flutter run -d android
```

**iOS:**
```bash
flutter run -d ios
```

### Verificar Firebase

```bash
firebase projects:list
firebase use <project-id>
```

### Verificar Cloud Functions

```bash
cd firebase/functions
npm test
```

## Troubleshooting

### Problemas Comunes

1. **Error de dependencias:**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Error de Firebase:**
   - Verificar archivos de configuración
   - Verificar permisos en Firebase Console

3. **Error de build:**
   - Verificar versión de Flutter
   - Verificar configuración de plataforma

## Próximos Pasos

1. [Estructura del Proyecto](./04-estructura-proyecto.md) - Conoce la organización del código
2. [Backend Firebase](./05-backend-firebase.md) - Entiende Firestore y servicios

---

**Anterior:** [Arquitectura ←](./02-arquitectura.md) | **Siguiente:** [Estructura del Proyecto →](./04-estructura-proyecto.md)

