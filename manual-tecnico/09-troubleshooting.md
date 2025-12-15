---
layout: default
title: Troubleshooting
parent: Manual Técnico
nav_order: 9
---

# Troubleshooting

Problemas comunes y sus soluciones.

## Problemas de Instalación

### Error: "Could not find a file named 'pubspec.yaml'"

**Solución:**
```bash
cd Capi-App
flutter pub get
```

### Error: Dependencias conflictivas

**Solución:**
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Error: Versión de Flutter incompatible

**Solución:**
```bash
flutter upgrade
flutter doctor
```

## Problemas de Firebase

### Error: "FirebaseApp not initialized"

**Solución:**
1. Verificar que `google-services.json` (Android) o `GoogleService-Info.plist` (iOS) están en la ubicación correcta
2. Verificar que Firebase está inicializado antes de usarlo:
   ```dart
   await Firebase.initializeApp();
   ```

### Error: Permisos denegados en Firestore

**Solución:**
1. Verificar reglas de Firestore
2. Verificar que el usuario está autenticado
3. Verificar que el usuario tiene los permisos necesarios

### Error: "Missing or insufficient permissions"

**Solución:**
1. Verificar reglas de Firestore en `firebase/firestore.rules`
2. Verificar que el usuario pertenece a la clínica correcta
3. Verificar permisos del usuario en `UsersRecord`

## Problemas de Autenticación

### Error: "User not found"

**Solución:**
1. Verificar que el usuario existe en Firebase Auth
2. Verificar que existe `UsersRecord` en Firestore
3. Verificar que el email es correcto

### Error: "Invalid email or password"

**Solución:**
1. Verificar credenciales
2. Verificar que el usuario no está deshabilitado
3. Intentar resetear contraseña

### Error: Sesión expirada

**Solución:**
```dart
// Reautenticar usuario
await FirebaseAuth.instance.currentUser?.reload();
```

## Problemas de Notificaciones

### Notificaciones no llegan en Android

**Solución:**
1. Verificar que `google-services.json` está configurado
2. Verificar permisos en `AndroidManifest.xml`
3. Verificar que el token FCM está registrado
4. Verificar que el dispositivo tiene Google Play Services

### Notificaciones no llegan en iOS

**Solución:**
1. Verificar configuración de APNs en Firebase Console
2. Verificar certificados en Apple Developer
3. Verificar permisos en `Info.plist`
4. Verificar que el usuario aceptó permisos de notificación

### Notificaciones no llegan en Web

**Solución:**
1. Verificar que `firebase-messaging-sw.js` está en la raíz de `web/`
2. Verificar que el servicio worker está registrado
3. Verificar permisos del navegador
4. Verificar que se está usando HTTPS

## Problemas de Stripe

### Error: "Invalid API key"

**Solución:**
1. Verificar que las API keys están correctas en `app_constants.dart`
2. Verificar que se está usando la key correcta (test vs live)
3. Verificar que la key tiene los permisos necesarios

### Error: Suscripción no se actualiza

**Solución:**
1. Verificar webhooks de Stripe
2. Verificar que N8N está procesando los webhooks
3. Verificar logs de Cloud Functions
4. Verificar que el webhook secret está configurado

## Problemas de Zoom

### Error: "Invalid token"

**Solución:**
1. Verificar que el token de Zoom es válido
2. Verificar que el token no ha expirado
3. Regenerar token si es necesario

### Error: Reunión no se crea

**Solución:**
1. Verificar credenciales de Zoom API
2. Verificar que la cuenta de Zoom tiene permisos
3. Verificar logs de la API call

## Problemas de Build

### Error: Build falla en Android

**Solución:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

### Error: Build falla en iOS

**Solución:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter build ios
```

### Error: Build falla en Web

**Solución:**
```bash
flutter clean
flutter pub get
flutter build web --web-renderer html
```

## Problemas de Performance

### App lenta al cargar

**Solución:**
1. Verificar queries de Firestore (usar índices)
2. Implementar paginación en listas
3. Usar caché cuando sea posible
4. Optimizar imágenes

### Alto uso de datos

**Solución:**
1. Implementar paginación
2. Limitar queries de Firestore
3. Usar caché local
4. Optimizar tamaño de imágenes

## Debugging

### Habilitar Logs

```dart
// En main.dart
void main() {
  // Habilitar logs de debug
  debugPrint('Debug mode enabled');
  runApp(MyApp());
}
```

### Ver Logs de Firebase

```bash
firebase functions:log
```

### Ver Logs de Flutter

```bash
flutter logs
```

## Recursos Adicionales

- [Documentación de Flutter](https://flutter.dev/docs)
- [Documentación de Firebase](https://firebase.google.com/docs)
- [Troubleshooting de Firestore](./referencias/troubleshooting/)
- [Documentación de Stripe](https://stripe.com/docs)

---

**Anterior:** [Despliegue ←](./08-despliegue.md) | **Volver:** [Manual Técnico](./index.md)

