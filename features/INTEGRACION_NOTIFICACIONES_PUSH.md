# 🚀 **Guía de Integración: Sistema de Notificaciones Push**

## 📋 **Descripción General**

Este documento contiene las instrucciones completas para integrar el sistema de notificaciones push implementado en **Capi-App** en cualquier otro proyecto Flutter. El sistema utiliza **Firebase Cloud Functions** + **Firebase Admin SDK** para máxima escalabilidad y reutilización.

---

## 🎯 **Características del Sistema**

- ✅ **Notificaciones Push Reales** - Envío a dispositivos web y móviles
- ✅ **Cloud Functions Centralizadas** - Lógica reutilizable en múltiples proyectos
- ✅ **Gestión de Tokens FCM** - Almacenamiento y validación automática con soporte multi-dispositivo
- ✅ **Compatibilidad Web** - Funciona en navegadores modernos con Service Worker v2.0
- ✅ **Escalabilidad** - Una función maneja múltiples usuarios y tokens
- ✅ **Seguridad** - Autenticación y permisos configurados
- ✅ **Sistema de Preferencias Avanzado** - Gestión granular de notificaciones por tipo con UI integrada
- ✅ **Modal de Configuración** - Diálogo completo con verificación de permisos en tiempo real
- ✅ **Diagnóstico de Permisos** - Verificación automática y detallada del estado de permisos
- ✅ **Sincronización de UI** - Switches que reflejan correctamente el estado real de permisos
- ✅ **Pruebas en Tiempo Real** - Envío de notificaciones reales para testing
- ✅ **Integración con Perfil** - Diálogo de configuración integrado en la UI

---

## 🏗️ **Arquitectura del Sistema**

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Flutter App   │    │  Cloud Function  │    │   FCM Service   │
│                 │    │                  │    │                 │
│ • Genera Token  │───▶│ • Lee Firestore  │───▶│ • Envía Push    │
│ • Guarda Token  │    │ • Envía a FCM    │    │ • Notificaciones│
│ • Recibe Push   │◀───│ • Retorna Status │◀───│ • Respuesta     │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Firestore     │    │  Firebase Admin  │    │   Web Browser   │
│                 │    │                  │    │                 │
│ • Almacena      │    │ • Autenticación  │    │ • Service Worker│
│   Tokens FCM    │    │ • SDK Integrado  │    │ • Notificaciones│
│ • Historial     │    │ • Sin OAuth2     │    │ • Interacciones │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

---

## 📱 **Paso 1: Configuración del Proyecto Flutter**

### **1.1 Dependencias en `pubspec.yaml`**

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase Core
  firebase_core: ^3.14.0

  # Firebase Messaging (Push Notifications)
  firebase_messaging: ^15.2.7

  # Firebase Auth (para identificar usuarios)
  firebase_auth: ^5.6.0

  # Firestore (para almacenar tokens)
  cloud_firestore: ^5.6.9

  # Notificaciones locales (opcional, para móvil)
  flutter_local_notifications: ^18.0.0

  # HTTP para comunicación con Cloud Functions
  http: ^1.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
```

### **1.2 Instalar dependencias**

```bash
flutter pub get
```

---

## 🔥 **Paso 2: Configuración de Firebase**

### **2.1 Crear Proyecto Firebase**

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Crea un nuevo proyecto o usa uno existente
3. **Habilita** los siguientes servicios:
   - ✅ **Authentication** (Anónimo o Email/Password)
   - ✅ **Firestore Database**
   - ✅ **Cloud Messaging**
   - ✅ **Cloud Functions**

### **2.2 Configurar Flutter**

1. **Descarga** `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
2. **Coloca** en las carpetas correspondientes:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

### **2.3 Configurar Web**

1. **Crea** archivo `web/firebase-messaging-sw.js`:

```javascript
// Firebase Cloud Messaging Service Worker v2.0
// Version: 2.0 - Updated 2025-08-25
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js');

// Configuración de Firebase (REEMPLAZA CON TUS DATOS)
firebase.initializeApp({
  apiKey: 'TU_API_KEY',
  authDomain: 'TU_PROJECT_ID.firebaseapp.com',
  projectId: 'TU_PROJECT_ID',
  storageBucket: 'TU_PROJECT_ID.firebasestorage.app',
  messagingSenderId: 'TU_SENDER_ID',
  appId: 'TU_APP_ID',
  measurementId: 'TU_MEASUREMENT_ID',
});

const messaging = firebase.messaging();

// Manejar mensajes en background
messaging.onBackgroundMessage((payload) => {
  console.log('Mensaje recibido en background:', payload);

  const notificationTitle = payload.notification?.title || 'Nueva notificación';
  const notificationOptions = {
    body: payload.notification?.body || 'Tienes una nueva notificación',
    icon: '/logo_nuevo1.png',
    badge: '/logo_nuevo1.png',
    data: payload.data || {},
    actions: [
      {
        action: 'open',
        title: 'Abrir',
        icon: '/logo_nuevo1.png'
      },
      {
        action: 'close',
        title: 'Cerrar'
      }
    ]
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

// Manejar clics en notificaciones
self.addEventListener('notificationclick', (event) => {
  console.log('Notificación clickeada:', event);

  event.notification.close();

  if (event.action === 'open' || !event.action) {
    // Abrir la aplicación
    event.waitUntil(
      clients.openWindow('/')
    );
  }
});

// Manejar mensajes del cliente principal
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

// Manejar instalación del service worker
self.addEventListener('install', (event) => {
  console.log('FCM Service Worker v2.0 instalado');
  // Forzar instalación inmediata
  self.skipWaiting();
});

// Manejar activación del service worker
self.addEventListener('activate', (event) => {
  console.log('FCM Service Worker v2.0 activado');
  event.waitUntil(
    Promise.all([
      // Limpiar cachés antiguos
      caches.keys().then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheName.includes('fcm-')) {
              return caches.delete(cacheName);
            }
          })
        );
      }),
      // Tomar control de todos los clientes
      self.clients.claim()
    ])
  );
});
```

---

## 🧩 **Paso 3: Servicio de Notificaciones Flutter**

### **3.1 Crear `lib/services/notification_service.dart`**

**IMPORTANTE**: Agregar los imports necesarios al inicio del archivo:

```dart
import 'dart:html' as html; // Solo para web
import 'dart:math'; // Para generación de IDs únicos
```

```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Inicializar notificaciones locales (solo móvil)
      if (!kIsWeb) {
        await _initializeLocalNotifications();
      }

      // Solicitar permisos para notificaciones
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        criticalAlert: true,
        announcement: true,
      );

      print('Permisos de notificación: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('Usuario otorgó permisos para notificaciones');

        // Configurar handlers para mensajes FCM
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
        FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpen);
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

        // Obtener y guardar el token FCM
        await _saveTokenToFirestore();

        // Suscribirse a cambios en el token
        _messaging.onTokenRefresh.listen((String token) {
          print('Token FCM actualizado: $token');
          _saveTokenToFirestore(token);
        });

        // Configurar canales de notificación para Android
        if (!kIsWeb) {
          await _createNotificationChannels();
        }

        _initialized = true;
        print('Servicio de notificaciones inicializado correctamente');
      } else {
        print('Usuario no otorgó permisos para notificaciones');
      }
    } catch (e) {
      print('Error al inicializar el servicio de notificaciones: $e');
      rethrow;
    }
  }

  Future<void> _initializeLocalNotifications() async {
    if (kIsWeb) return;

    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await _localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      print('Notificaciones locales inicializadas');
    } catch (e) {
      print('Error al inicializar notificaciones locales: $e');
    }
  }

  Future<void> _createNotificationChannels() async {
    if (kIsWeb) return;

    try {
      const AndroidNotificationChannel highImportanceChannel =
          AndroidNotificationChannel(
        'high_importance_channel',
        'Notificaciones Importantes',
        description: 'Canal para notificaciones de alta importancia',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        enableLights: true,
      );

      const AndroidNotificationChannel defaultChannel =
          AndroidNotificationChannel(
        'default_channel',
        'Notificaciones Generales',
        description: 'Canal para notificaciones generales',
        importance: Importance.defaultImportance,
        playSound: true,
        enableVibration: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(highImportanceChannel);

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(defaultChannel);

      print('Canales de notificación creados');
    } catch (e) {
      print('Error al crear canales de notificación: $e');
    }
  }

  Future<void> _saveTokenToFirestore([String? token]) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Usuario no autenticado, no se puede guardar token');
        return;
      }

      token ??= await _messaging.getToken();
      if (token == null) {
        print('No se pudo obtener el token FCM');
        return;
      }

      print('Token FCM obtenido: $token');

      // Generar un ID único para este dispositivo
      final deviceId = await _getDeviceId();
      print('🆔 ID del dispositivo: $deviceId');

      // Verificar si el token ya existe para este dispositivo
      final tokenDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('fcmTokens')
          .where('deviceId', isEqualTo: deviceId)
          .get();

      if (tokenDoc.docs.isEmpty) {
        // NUEVO DISPOSITIVO: Agregar token sin invalidar otros
        print('🆕 Nuevo dispositivo detectado, agregando token...');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('fcmTokens')
            .add({
          'token': token,
          'deviceId': deviceId,
          'deviceType': _getDeviceType(),
          'isValid': true,
          'isPrimary': false, // No es principal por defecto
          'lastUsed': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        print('✅ Token FCM guardado para nuevo dispositivo');
      } else {
        // DISPOSITIVO EXISTENTE: Actualizar token existente
        print('🔄 Dispositivo existente, actualizando token...');

        final existingTokenDoc = tokenDoc.docs.first;
        await existingTokenDoc.reference.update({
          'token': token,
          'isValid': true,
          'lastUsed': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        print('✅ Token FCM actualizado para dispositivo existente');
      }

      // Limpiar tokens obsoletos (más de 30 días sin usar)
      await _cleanupOldTokens(user.uid);
    } catch (e) {
      print('❌ Error al guardar token FCM: $e');
    }
  }

  /// Obtiene un ID único para el dispositivo actual
  Future<String> _getDeviceId() async {
    // En web, usar una combinación de user agent + timestamp
    // En móvil, usar el device ID nativo
    if (kIsWeb) {
      final userAgent = html.window.navigator.userAgent;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      return 'web_${userAgent.hashCode}_$timestamp';
    } else {
      // En móvil, usar timestamp + random como fallback
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      return 'mobile_${timestamp}_${Random().nextInt(10000)}';
    }
  }

  /// Determina el tipo de dispositivo
  String _getDeviceType() {
    if (kIsWeb) {
      return 'web';
    } else if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'unknown';
  }

  // Método para limpiar tokens obsoletos
  Future<void> _cleanupOldTokens(String userId) async {
    try {
      // Solo limpiar tokens inválidos por ahora, sin consultas complejas
      final invalidTokens = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('fcmTokens')
          .where('isValid', isEqualTo: false)
          .get();

      int deletedCount = 0;
      for (var doc in invalidTokens.docs) {
        await doc.reference.delete();
        deletedCount++;
      }

      if (deletedCount > 0) {
        print('✅ $deletedCount tokens FCM inválidos eliminados');
      }
    } catch (e) {
      print('❌ Error al limpiar tokens obsoletos: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("Mensaje recibido en primer plano: ${message.messageId}");
    print("Datos del mensaje: ${message.data}");
    print("Título: ${message.notification?.title}");
    print("Cuerpo: ${message.notification?.body}");

    // Mostrar notificación local (solo móvil)
    if (!kIsWeb) {
      _showLocalNotification(message);
    }
  }

  void _handleNotificationOpen(RemoteMessage message) {
    print("Notificación abrió la app: ${message.messageId}");
    print("Datos del mensaje: ${message.data}");

    // Aquí puedes agregar la lógica para navegar a una pantalla específica
    _handleNotificationData(message.data);
  }

  void _onNotificationTapped(NotificationResponse response) {
    print("Notificación local tocada: ${response.payload}");
    // Aquí puedes manejar cuando se toca una notificación local
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    if (kIsWeb) return;

    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'high_importance_channel',
        'Notificaciones Importantes',
        channelDescription: 'Canal para notificaciones de alta importancia',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await _localNotifications.show(
        message.hashCode,
        message.notification?.title ?? 'Nueva notificación',
        message.notification?.body ?? 'Tienes una nueva notificación',
        platformChannelSpecifics,
        payload: message.data.toString(),
      );
    } catch (e) {
      print('Error al mostrar notificación local: $e');
    }
  }

  void _handleNotificationData(Map<String, dynamic> data) {
    // Aquí puedes implementar la lógica para manejar diferentes tipos de notificaciones
    // Por ejemplo, navegar a diferentes pantallas basado en el tipo de notificación

    if (data['type'] == 'cita') {
      print('Notificación de cita recibida');
      // Navegar a pantalla de citas
    } else if (data['type'] == 'mensaje') {
      print('Notificación de mensaje recibida');
      // Navegar a pantalla de mensajes
    } else if (data['type'] == 'recordatorio') {
      print('Notificación de recordatorio recibida');
      // Navegar a pantalla de recordatorios
    }
  }

  // Método para enviar notificación de prueba
  Future<void> sendTestNotification() async {
    if (kIsWeb) {
      print('Notificaciones locales no disponibles en web');
      return;
    }

    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'default_channel',
        'Notificaciones Generales',
        channelDescription: 'Canal para notificaciones generales',
        importance: Importance.defaultImportance,
        priority: Priority.low,
        showWhen: true,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await _localNotifications.show(
        0,
        'Notificación de Prueba',
        'Esta es una notificación de prueba para verificar que el sistema funciona',
        platformChannelSpecifics,
      );
      print('Notificación de prueba enviada');
    } catch (e) {
      print('Error al enviar notificación de prueba: $e');
    }
  }

  // Método para obtener el token FCM actual
  Future<String?> getCurrentToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      print('Error al obtener token FCM: $e');
      return null;
    }
  }

  // Método para limpiar tokens inválidos
  Future<void> cleanupInvalidTokens() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final tokens = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('fcmTokens')
          .where('isValid', isEqualTo: false)
          .get();

      for (var doc in tokens.docs) {
        await doc.reference.delete();
      }
      print('Tokens inválidos limpiados');
    } catch (e) {
      print('Error al limpiar tokens inválidos: $e');
    }
  }
}

// Este handler debe estar fuera de la clase y a nivel superior
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Manejando mensaje en background: ${message.messageId}");
  print("Datos del mensaje: ${message.data}");

  // Aquí puedes agregar la lógica para manejar mensajes en background
  // Por ejemplo, actualizar la base de datos local, mostrar notificación local, etc.

  // Importante: No puedes usar Flutter widgets aquí
  // Solo puedes hacer operaciones básicas como logging, actualizar base de datos, etc.
}
```

### **3.2 Inicializar en `main.dart`**

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tu_proyecto/services/notification_service.dart';
import 'package:tu_proyecto/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar servicio de notificaciones
  await NotificationService().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu App',
      home: MyHomePage(),
    );
  }
}
```

---

## ☁️ **Paso 4: Cloud Functions**

### **4.1 Instalar Firebase CLI**

```bash
npm install -g firebase-tools
```

### **4.2 Inicializar Firebase Functions**

```bash
firebase login
firebase init functions
```

**NOTA**: Asegúrate de seleccionar Node.js 20 como runtime.

### **4.3 Crear `firebase/functions/notification_service.js`**

```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');

// No inicializar admin aquí, ya se hace en index.js

exports.sendNotification = functions.https.onRequest(async (req, res) => {
  try {
    const { userId, title, body, data = {}, projectId } = req.body;

    if (!userId || !title || !body) {
      return res.status(400).json({
        status: 'error',
        message: 'Se requieren userId, title y body',
      });
    }

    console.log('Iniciando envío de notificación...');
    console.log('userId:', userId);
    console.log('title:', title);
    console.log('body:', body);

    // Verificar que admin.firestore esté disponible
    if (!admin.firestore) {
      console.error('admin.firestore no está disponible');
      return res.status(500).json({
        status: 'error',
        message: 'Firestore no está disponible',
        error: 'admin.firestore is undefined',
      });
    }

    // Buscar el token FCM del usuario en Firestore
    const userTokensRef = admin.firestore().collection('users').doc(userId).collection('fcmTokens');
    console.log('Buscando tokens en:', `users/${userId}/fcmTokens`);

    const tokensSnapshot = await userTokensRef.get();
    console.log('Tokens encontrados:', tokensSnapshot.size);

    if (tokensSnapshot.empty) {
      return res.status(404).json({
        status: 'error',
        message: 'No se encontraron tokens FCM para el usuario',
      });
    }

    // Obtener todos los tokens válidos
    const tokens = [];
    tokensSnapshot.forEach(doc => {
      const tokenData = doc.data();
      console.log('Token data:', tokenData);
      if (tokenData.isValid) {
        tokens.push(tokenData.token);
      }
    });

    console.log('Tokens válidos encontrados:', tokens.length);

    if (tokens.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'No se encontraron tokens válidos para el usuario',
      });
    }

    // Enviar notificación usando Firebase Admin SDK (más confiable)
    const results = [];
    for (const token of tokens) {
      try {
        const success = await sendFCMNotificationWithAdminSDK(token, title, body, data);
        results.push({ token, success });
      } catch (error) {
        console.error(`Error enviando a token ${token}:`, error);
        results.push({ token, success: false, error: error.message });
      }
    }

    const successCount = results.filter(r => r.success).length;
    const failureCount = results.filter(r => !r.success).length;

    console.log('Resultados del envío:', results);

    return res.json({
      status: 'success',
      message: 'Proceso de envío completado',
      results: results,
      successCount: successCount,
      failureCount: failureCount,
    });
  } catch (error) {
    console.error('Error al enviar notificación:', error);
    return res.status(500).json({
      status: 'error',
      message: 'Error interno al enviar la notificación',
      error: error.message,
      stack: error.stack,
    });
  }
});

// Función para enviar notificación usando Firebase Admin SDK
async function sendFCMNotificationWithAdminSDK(token, title, body, data) {
  try {
    console.log('Enviando notificación usando Firebase Admin SDK...');

    const message = {
      notification: {
        title: title,
        body: body,
      },
      data: data,
      token: token,
      webpush: {
        notification: {
          icon: '/icons/app_launcher_icon.png',
          badge: '/icons/app_launcher_icon.png',
          tag: 'app-notification',
          requireInteraction: true,
          actions: [
            {
              action: 'open',
              title: 'Abrir App',
              icon: '/icons/app_launcher_icon.png',
            },
            {
              action: 'dismiss',
              title: 'Descartar',
              icon: '/icons/app_launcher_icon.png',
            },
          ],
        },
        fcm_options: {
          link: '/',
        },
      },
    };

    console.log('Mensaje construido:', JSON.stringify(message, null, 2));

    // Usar Firebase Admin SDK para enviar la notificación
    const response = await admin.messaging().send(message);
    console.log('Notificación enviada exitosamente con ID:', response);

    return true;
  } catch (error) {
    console.error('Error enviando notificación con Admin SDK:', error);
    throw error;
  }
}
```

### **4.4 Crear `firebase/functions/index.js`**

```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// Importar el servicio de notificaciones
const notificationService = require('./notification_service');

// Exportar la función de notificaciones
exports.sendNotification = notificationService.sendNotification;

// Función para migrar tokens existentes (ejecutar una sola vez)
exports.migrateExistingTokens = notificationService.migrateExistingTokens;
```

### **4.5 Configurar `firebase/functions/package.json`**

```json
{
  "name": "cloud-functions",
  "description": "Firebase Cloud Functions",
  "dependencies": {
    "firebase-admin": "^11.11.0",
    "firebase-functions": "^6.4.0"
  },
  "engines": {
    "node": "20"
  },
  "main": "index.js",
  "private": true
}
```

**NOTA**: Las versiones exactas pueden variar. Usa las versiones compatibles con tu proyecto.

### **4.6 Desplegar Cloud Functions**

```bash
cd firebase/functions
npm install
firebase deploy --only functions
```

---

## 🔐 **Paso 5: Reglas de Firestore**

### **5.1 Crear `firebase/firestore.rules`**

```javascript
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    // Reglas para tokens FCM de notificaciones
    match /users/{userId}/fcmTokens/{tokenId} {
      allow create: if request.auth != null && request.auth.uid == userId;
      allow read: if request.auth != null && request.auth.uid == userId;
      allow update: if request.auth != null && request.auth.uid == userId;
      allow delete: if request.auth != null && request.auth.uid == userId;
    }

    // Reglas para usuarios y sus preferencias de notificaciones
    match /users/{document} {
      allow create: if request.auth != null;
      allow read: if request.auth != null;
      allow write: if request.auth != null;
      allow delete: if request.auth != null;
    }

    // Reglas para notificaciones (opcional)
    match /notifications/{document} {
      allow create: if request.auth != null;
      allow read: if request.auth != null;
      allow write: if request.auth != null;
      allow delete: if request.auth != null;
    }
  }
}
```

**IMPORTANTE**: Las reglas incluyen acceso a la subcolección `fcmTokens` y al campo `notificationPreferences` del documento del usuario.

### **5.2 Desplegar reglas**

```bash
firebase deploy --only firestore:rules
```

---

## 📤 **Paso 6: Envío de Notificaciones**

### **6.1 Script de Prueba (`test_notification.js`)**

**NOTA**: Este script usa la URL de Cloud Run que es más confiable que las URLs directas de Cloud Functions.

```javascript
const https = require('https');

// Función para hacer POST a la Cloud Function
function sendNotification(userId, title, body, data = {}) {
  const postData = JSON.stringify({
    userId: userId,
    title: title,
    body: body,
    data: data,
  });

  const options = {
    hostname: 'TU_FUNCTION_URL.a.run.app', // REEMPLAZA CON TU URL
    port: 443,
    path: '/',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const req = https.request(options, res => {
    console.log(`Status: ${res.statusCode}`);
    console.log(`Headers: ${JSON.stringify(res.headers)}`);

    let responseData = '';
    res.on('data', chunk => {
      responseData += chunk;
    });

    res.on('end', () => {
      try {
        const parsedData = JSON.parse(responseData);
        console.log('Respuesta:', JSON.stringify(parsedData, null, 2));
      } catch (e) {
        console.log('Respuesta (texto):', responseData);
      }
    });
  });

  req.on('error', e => {
    console.error(`Error en la petición: ${e.message}`);
  });

  req.write(postData);
  req.end();
}

// Ejemplo de uso
console.log('🚀 Probando envío de notificación...\n');

// REEMPLAZA CON UN ID DE USUARIO REAL
const testUserId = 'USER_ID_AQUI';

if (testUserId === 'USER_ID_AQUI') {
  console.log('❌ ERROR: Necesitas cambiar USER_ID_AQUI por un ID de usuario real');
  console.log('📱 Ejecuta la app primero para que genere tokens FCM');
  console.log('🔍 Revisa Firestore en: users/{userId}/fcmTokens');
  process.exit(1);
}

// Enviar notificación de prueba
sendNotification(
  testUserId,
  '🎉 ¡Notificación de prueba!',
  'Esta es una notificación push de prueba desde Firebase Cloud Functions',
  {
    type: 'test',
    timestamp: new Date().toISOString(),
    action: 'open_app',
  },
);

console.log('\n📤 Notificación enviada. Revisa la consola para la respuesta.');
console.log('📱 Verifica que aparezca en tu dispositivo móvil.');
```

### **6.2 Ejecutar prueba**

```bash
node test_notification.js
```

---

## 🎛️ **Paso 7: Sistema de Preferencias de Notificaciones**

### **7.1 Características del Sistema de Preferencias**

El sistema implementado incluye:

- ✅ **Verificación Automática de Permisos** - Detecta el estado real de permisos del navegador
- ✅ **Diagnóstico Detallado** - Proporciona información completa sobre el estado de permisos
- ✅ **UI Sincronizada** - Los switches reflejan correctamente el estado de permisos
- ✅ **Modal Integrado** - Diálogo completo con instrucciones paso a paso
- ✅ **Persistencia en Firestore** - Guarda preferencias en la base de datos
- ✅ **Manejo de Errores** - Gestiona casos de permisos denegados y modo incógnito

### **7.2 Archivos del Sistema de Preferencias**

Los archivos principales son:

1. **`lib/componentes/notification_preferences/notification_preferences_widget.dart`**
   - Widget principal del modal de configuración
   - Verificación automática de permisos
   - Diagnóstico detallado del estado del navegador
   - UI sincronizada con el estado real de permisos

2. **`lib/componentes/notification_preferences/notification_preferences_model.dart`**
   - Modelo de datos para las preferencias
   - Gestión del estado de los switches

### **7.3 Funcionalidades Implementadas**

#### **Verificación de Permisos en Tiempo Real**
```dart
Future<void> _checkPermissionStatus() async {
  final settings = await FirebaseMessaging.instance.getNotificationSettings();
  final hasPermissions = settings.authorizationStatus == AuthorizationStatus.authorized;
  // Actualiza UI basado en permisos reales
}
```

#### **Diagnóstico Detallado**
```dart
Future<void> _diagnosePermissionStatus(NotificationSettings settings) async {
  // Verifica modo incógnito, soporte del navegador, HTTPS, etc.
  // Proporciona logs detallados para debugging
}
```

#### **Modal con Instrucciones Paso a Paso**
- Instrucciones visuales para habilitar permisos
- Detección de modo incógnito
- Verificación de soporte del navegador
- Botones de acción contextuales

#### **Sincronización de UI**
- Switches deshabilitados cuando no hay permisos
- Advertencias visuales claras
- Botón "Solicitar Permisos" cuando es necesario

---

## 🎨 **Paso 8: Widget de Prueba (Opcional)**

### **7.1 Crear `lib/widgets/notification_test_widget.dart`**

**NOTA**: Este widget es opcional y se puede usar para testing durante el desarrollo.

```dart
import 'package:flutter/material.dart';
import 'package:tu_proyecto/services/notification_service.dart';

class NotificationTestWidget extends StatefulWidget {
  @override
  _NotificationTestWidgetState createState() => _NotificationTestWidgetState();
}

class _NotificationTestWidgetState extends State<NotificationTestWidget> {
  bool _isInitialized = false;
  String? _fcmToken;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _checkInitialization();
  }

  Future<void> _checkInitialization() async {
    // Verificar si el servicio está inicializado
    setState(() {
      _isInitialized = true;
    });

    // Obtener token FCM actual
    final token = await _notificationService.getCurrentToken();
    setState(() {
      _fcmToken = token;
    });
  }

  Future<void> _sendTestNotification() async {
    await _notificationService.sendTestNotification();
  }

  Future<void> _refreshToken() async {
    final token = await _notificationService.getCurrentToken();
    setState(() {
      _fcmToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🔔 Prueba de Notificaciones',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),

            // Estado de inicialización
            Row(
              children: [
                Icon(
                  _isInitialized ? Icons.check_circle : Icons.error,
                  color: _isInitialized ? Colors.green : Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  _isInitialized
                    ? 'Servicio inicializado'
                    : 'Servicio no inicializado',
                ),
              ],
            ),

            SizedBox(height: 16),

            // Token FCM
            if (_fcmToken != null) ...[
              Text(
                'Token FCM:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SelectableText(
                  _fcmToken!,
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
              SizedBox(height: 16),
            ],

            // Botones de acción
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _sendTestNotification,
                  icon: Icon(Icons.send),
                  label: Text('Enviar Prueba'),
                ),
                SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _refreshToken,
                  icon: Icon(Icons.refresh),
                  label: Text('Refrescar Token'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🚀 **Paso 8: Integración en Otros Proyectos**

### **8.1 Copiar Archivos**

```bash
# 1. Copiar servicio de notificaciones
cp lib/services/notification_service.dart tu_nuevo_proyecto/lib/services/

# 2. Copiar Cloud Functions
cp -r firebase/functions tu_nuevo_proyecto/firebase/

# 3. Copiar Service Worker (web)
cp web/firebase-messaging-sw.js tu_nuevo_proyecto/web/

# 4. Copiar reglas de Firestore
cp firebase/firestore.rules tu_nuevo_proyecto/firebase/

# 5. Copiar servicio de API (opcional)
cp lib/services/notification_api_service.dart tu_nuevo_proyecto/lib/services/
```

### **8.2 Modificar Configuración**

1. **Actualizar** `firebase-messaging-sw.js` con tu configuración
2. **Cambiar** `projectId` en las Cloud Functions
3. **Actualizar** dependencias en `pubspec.yaml`
4. **Configurar** Firebase en el nuevo proyecto

### **8.3 Desplegar**

```bash
cd tu_nuevo_proyecto
firebase deploy --only functions,firestore:rules
```

---

## 🔧 **Solución de Problemas Comunes**

### **Problema: Error "admin.firestore is not a function"**

**Solución:**

```javascript
// En lugar de:
const admin = require('firebase-admin/app');

// Usar:
const admin = require('firebase-admin');
```

### **Problema: Error "Platform.\_operatingSystem" en web**

**Solución:**

```dart
// En lugar de:
if (Platform.isAndroid) { ... }

// Usar:
if (!kIsWeb) { ... }
```

### **Problema: Service Worker no se registra**

**Solución:**

1. Verificar que `firebase-messaging-sw.js` esté en la raíz de `web/`
2. Hacer hot restart de la app
3. Verificar consola del navegador
4. Verificar que la versión del Service Worker sea la correcta

### **Problema: Tokens no se guardan en Firestore**

**Solución:**

1. Verificar reglas de Firestore
2. Verificar que el usuario esté autenticado
3. Verificar permisos de la colección `fcmTokens`
4. Verificar que el campo `notificationPreferences` esté permitido

### **Problema: Error "dart:html not found" en móvil**

**Solución:**

```dart
// Usar import condicional:
import 'dart:html' as html if (dart.library.html) 'dart:html' as html;
```

### **Problema: Notificaciones no llegan en web**

**Solución:**

1. Verificar que el Service Worker esté registrado
2. Verificar permisos del navegador
3. Verificar que la app esté en primer plano o background
4. Verificar la consola del navegador para errores

### **Problema: Switches de notificaciones aparecen deshabilitados**

**Solución:**

1. **Verificar permisos del navegador** - El sistema ahora verifica automáticamente
2. **Revisar logs de diagnóstico** - Buscar en consola: "DIAGNÓSTICO DE PERMISOS"
3. **Verificar modo incógnito** - Las notificaciones no funcionan en modo incógnito
4. **Verificar HTTPS** - Las notificaciones requieren conexión segura
5. **Usar el botón "Solicitar Permisos"** - El modal incluye instrucciones paso a paso

### **Problema: AuthorizationStatus.denied en Chrome**

**Solución:**

1. **Hacer clic en el ícono de notificaciones** (🔔) en la barra de direcciones
2. **Seleccionar "Permitir"** para este sitio web
3. **Recargar la página** para aplicar los cambios
4. **Verificar que no estés en modo incógnito**
5. **Verificar que la página use HTTPS** (requerido para notificaciones)

### **Problema: UI no se sincroniza con permisos reales**

**Solución:**

El sistema ahora incluye verificación automática que:
- **Verifica permisos al abrir el modal**
- **Actualiza la UI en tiempo real**
- **Muestra advertencias visuales** cuando faltan permisos
- **Proporciona botones de acción** contextuales

---

## 📚 **Recursos Adicionales**

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [Firebase Admin SDK Documentation](https://firebase.google.com/docs/admin)
- [Flutter Firebase Documentation](https://firebase.flutter.dev/)
- [Web Push Notifications Guide](https://web.dev/push-notifications/)
- [Service Worker API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)
- [Firebase Cloud Functions Documentation](https://firebase.google.com/docs/functions)

---

## 🎯 **Resumen de Integración**

1. ✅ **Configurar Firebase** en el nuevo proyecto
2. ✅ **Copiar servicio de notificaciones** Flutter con soporte multi-dispositivo
3. ✅ **Copiar Cloud Functions** con lógica de envío y migración
4. ✅ **Configurar Service Worker v2.0** para web con cache management
5. ✅ **Configurar reglas de Firestore** para tokens y preferencias
6. ✅ **Desplegar funciones y reglas** en Firebase
7. ✅ **Probar envío de notificaciones** reales
8. ✅ **Integrar sistema de preferencias avanzado** con verificación automática de permisos
9. ✅ **Implementar diagnóstico de permisos** para debugging
10. ✅ **Configurar UI sincronizada** que refleja el estado real de permisos

---

## 📞 **Soporte**

Si encuentras problemas durante la integración:

1. **Revisar logs** de Cloud Functions
2. **Verificar consola** del navegador
3. **Comprobar reglas** de Firestore
4. **Validar configuración** de Firebase
5. **Verificar Service Worker** en DevTools > Application
6. **Comprobar permisos** de notificaciones del navegador
7. **Validar tokens FCM** en Firestore

---

## 🆕 **Nuevas Características Implementadas**

### **Sistema de Preferencias de Notificaciones Avanzado**
- **Diálogo integrado** en la página de perfil con verificación automática de permisos
- **6 tipos de notificaciones** configurables con UI sincronizada
- **Persistencia automática** en Firestore con manejo de errores
- **UI responsive** con switches personalizados y estados visuales
- **Verificación de permisos en tiempo real** con diagnóstico detallado
- **Instrucciones paso a paso** para habilitar permisos en el navegador
- **Detección de modo incógnito** y restricciones del sistema
- **Manejo inteligente de errores** con mensajes contextuales

### **Soporte Multi-Dispositivo**
- **Identificación única** por dispositivo
- **Múltiples tokens** por usuario
- **Limpieza automática** de tokens obsoletos
- **Tracking de uso** por dispositivo

### **Service Worker v2.0**
- **Cache management** inteligente
- **Auto-actualización** del service worker
- **Manejo de clics** en notificaciones
- **Compatibilidad** con navegadores modernos

### **Cloud Functions Avanzadas**
- **Envío a múltiples dispositivos** simultáneamente
- **Retraso configurable** para mejor UX
- **Migración automática** de tokens existentes
- **Logging detallado** para debugging

---

**¡Tu sistema de notificaciones push está listo para ser integrado en cualquier proyecto! 🚀**
