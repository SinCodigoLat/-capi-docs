---
layout: default
title: Introducción
parent: Manual Técnico
nav_order: 1
---

# Introducción

## ¿Qué es CAPI App?

**CAPI** (Centro de Atención Integral) es una plataforma médica completa construida con Flutter que permite a clínicas y profesionales de la salud gestionar historiales clínicos electrónicos, consultas, citas y comunicarse con pacientes de manera eficiente y segura.

La aplicación cumple con normativas COFEPRIS para la gestión de expedientes clínicos electrónicos y protección de datos personales.

## Stack Tecnológico

### Frontend
- **Framework:** Flutter 3.0+
- **Lenguaje:** Dart 3.0+
- **Plataformas:** iOS, Android, Web (PWA)
- **UI Components:** FlutterFlow widgets
- **State Management:** Provider + FlutterFlow state management

### Backend
- **Base de Datos:** Firebase Firestore
- **Autenticación:** Firebase Auth
- **Storage:** Firebase Storage
- **Cloud Functions:** Node.js
- **Hosting:** Firebase Hosting (Web)

### Integraciones
- **Pagos:** Stripe API (suscripciones y Connect), RevenueCat (iOS)
- **Videoconsultas:** Zoom API
- **Notificaciones:** Firebase Cloud Messaging
- **Email:** N8N + SMTP
- **Búsqueda:** Algolia (opcional), Firestore queries
- **Maps/Places:** Google Places API
- **Workflows:** N8N

## Requisitos del Sistema

### Para Desarrollo

- **Flutter SDK:** Stable release (3.0.0 o superior)
- **Dart SDK:** 3.0.0 o superior
- **Firebase CLI:** Última versión
- **Git:** Para control de versiones
- **Node.js:** 18+ (para Cloud Functions)
- **npm/yarn:** Para dependencias de Node.js

### Para Producción

- **Firebase Project:** Configurado con Firestore, Auth, Storage, Functions
- **Stripe Account:** Para pagos y suscripciones
- **Zoom Account:** Para videoconsultas (opcional)
- **N8N Instance:** Para automatización de workflows
- **RevenueCat Account:** Para iOS in-app purchases (opcional)

## Arquitectura General

CAPI App sigue una arquitectura cliente-servidor con:

```
┌─────────────────────────────────────────┐
│         Flutter App (Cliente)           │
│  ┌──────────┐  ┌──────────┐           │
│  │   iOS    │  │ Android  │  │  Web   │
│  └──────────┘  └──────────┘           │
└─────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│         Firebase Backend                │
│  ┌──────────┐  ┌──────────┐           │
│  │ Firestore│  │   Auth   │           │
│  └──────────┘  └──────────┘           │
│  ┌──────────┐  ┌──────────┐           │
│  │ Storage │  │ Functions │           │
│  └──────────┘  └──────────┘           │
└─────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│      Servicios Externos                 │
│  ┌──────────┐  ┌──────────┐           │
│  │  Stripe  │  │   Zoom   │           │
│  └──────────┘  └──────────┘           │
│  ┌──────────┐  ┌──────────┐           │
│  │RevenueCat│  │   N8N    │           │
│  └──────────┘  └──────────┘           │
└─────────────────────────────────────────┘
```

## Características Principales

### Gestión Médica
- Expediente clínico electrónico completo
- Historia clínica digital
- Notas médicas con generación de PDF
- Consentimiento informado digital
- Gestión de archivos médicos

### Gestión de Usuarios
- Sistema de roles (Doctor, Paciente, Asistente)
- Permisos granulares (15+ permisos específicos)
- Control de acceso basado en clínicas
- Sistema de invitaciones

### Comunicación
- Chat en tiempo real
- Notificaciones push multi-plataforma
- Videoconsultas con Zoom
- Emails automáticos

### Pagos y Suscripciones
- Planes de suscripción (Starter, Premium, Elite)
- Stripe para pagos web
- RevenueCat para iOS
- Sistema de créditos AI

### Seguridad y Cumplimiento
- Cumplimiento COFEPRIS completo
- Auditoría de acciones
- Resguardo de datos (5 años)
- Sistema de derechos ARCO

## Estructura del Proyecto

```
Capi-App/
├── lib/                    # Código fuente Flutter
│   ├── auth/              # Autenticación
│   ├── backend/           # Backend y schemas
│   ├── clinica/           # Módulo de clínica
│   ├── paciente/          # Módulo de paciente
│   ├── chat/              # Sistema de chat
│   ├── componentes/       # Componentes reutilizables
│   ├── services/          # Servicios de negocio
│   └── custom_code/       # Código personalizado
├── firebase/              # Cloud Functions y configuración
├── docs/                  # Documentación
├── android/               # Configuración Android
├── ios/                   # Configuración iOS
└── web/                   # Configuración Web
```

## Próximos Pasos

1. [Arquitectura](./02-arquitectura.md) - Entiende la arquitectura del sistema
2. [Instalación y Configuración](./03-instalacion-configuracion.md) - Configura tu entorno de desarrollo

---

**Siguiente:** [Arquitectura →](./02-arquitectura.md)

