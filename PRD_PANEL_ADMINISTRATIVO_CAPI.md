# 📋 PRD - Panel Administrativo CAPI

## 🎯 RESUMEN EJECUTIVO

### **Objetivo Principal**
Desarrollar un panel administrativo web completo que permita a superadministradores y auditores gestionar, monitorear y auditar toda la plataforma CAPI, incluyendo cumplimiento COFEPRIS, auditoría de datos médicos y administración del sistema.

---

## 📊 ANÁLISIS DE STAKEHOLDERS

### **👥 Usuarios Objetivo**

#### **1. Superadministradores CAPI**
- **Rol:** Administración completa del sistema
- **Necesidades:** Control total, métricas de negocio, gestión de usuarios
- **Acceso:** Todas las funcionalidades

#### **2. Auditores COFEPRIS**
- **Rol:** Verificación de cumplimiento normativo
- **Necesidades:** Trazabilidad, reportes de auditoría, cumplimiento legal
- **Acceso:** Módulos de auditoría y compliance

#### **3. Administradores de Clínica**
- **Rol:** Gestión de clínicas específicas
- **Necesidades:** Métricas locales, gestión de usuarios, reportes
- **Acceso:** Módulos limitados por clínica

---

## 🏗️ ARQUITECTURA DEL SISTEMA

### **Stack Tecnológico**
- **Frontend:** React 18 + TypeScript
- **UI Framework:** shadcn/ui + Tailwind CSS
- **Componentes:** Radix UI primitives
- **Estado:** Zustand (ligero y moderno)
- **Gráficos:** Recharts (optimizado para React)
- **Autenticación:** Firebase Auth (ya implementado)
- **Base de Datos:** Firebase Firestore (ya implementado)
- **Hosting:** Vercel (optimizado para React)
- **Backend:** ✅ **YA IMPLEMENTADO** - Todas las APIs y servicios están listos

### **Estructura de Datos**
```typescript
// Conexión a la misma base de datos de CAPI
interface DatabaseConnection {
  firestore: Firestore;
  auth: Auth;
  storage: FirebaseStorage;
  functions: Functions;
}
```

---

## 🎨 ESPECIFICACIONES DE DISEÑO

### **🎨 Sistema de Diseño CAPI**

#### **Paleta de Colores (CAPI Brand)**
```css
/* Colores principales CAPI - Extraídos de FlutterFlowTheme */
:root {
  /* Primary - Azul CAPI característico */
  --primary: #0EADE0;           /* Color principal CAPI */
  --primary-foreground: #ffffff;
  --primary-hover: #0A7188;     /* Secondary CAPI */
  
  /* Secondary - Azul oscuro CAPI */
  --secondary: #0A7188;         /* Secondary CAPI */
  --secondary-foreground: #ffffff;
  --secondary-hover: #065a6f;   /* Hover state */
  
  /* Accent - Rojo CAPI */
  --accent: #F33131;             /* Tertiary CAPI */
  --accent-foreground: #ffffff;
  --accent-hover: #d62828;       /* Hover state */
  
  /* Neutral - Grises CAPI */
  --background: #ffffff;         /* Primary background */
  --foreground: #000000;         /* Primary text */
  --muted: #F0F1F1;              /* Fondo gris CAPI */
  --muted-foreground: #5A5C60;   /* Secondary text */
  --border: #E0E3E7;             /* Alternate CAPI */
  --input: #F0F1F1;              /* Fondo gris CAPI */
  
  /* Estados CAPI */
  --success: #02CA79;           /* Success CAPI */
  --warning: #C96F46;           /* Warning CAPI */
  --error: #E65454;             /* Error CAPI */
  --info: #0EADE0;               /* Info = Primary */
  
  /* Accents CAPI */
  --accent1: #B5FFFF;            /* Accent1 CAPI */
  --accent2: #8AC7FF;            /* Accent2 CAPI */
  --accent3: #EE8B60;            /* Accent3 CAPI */
  --accent4: #FFFFFF;            /* Accent4 CAPI */
  
  /* Dark mode */
  --dark-background: #1a1a1a;
  --dark-foreground: #ffffff;
  --dark-muted: #2a2a2a;
  --dark-border: #404040;
}
```

#### **Tipografía (CAPI Fonts)**
```css
/* Fuentes principales CAPI */
:root {
  /* Headings - Outfit (moderna, médica) */
  --font-heading: 'Outfit', -apple-system, BlinkMacSystemFont, sans-serif;
  
  /* Body - Inter (legibilidad) */
  --font-body: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  
  /* Monospace - JetBrains Mono */
  --font-mono: 'JetBrains Mono', 'Fira Code', monospace;
}



/* Border radius */
:root {
  --radius-sm: 0.375rem;    /* 6px */
  --radius-md: 0.5rem;      /* 8px */
  --radius-lg: 0.75rem;     /* 12px */
  --radius-xl: 1rem;        /* 16px */
}
```

### **1. Layout Principal con shadcn/ui**

#### **Header Global**
```tsx
// Componente Header con shadcn/ui
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Bell, Search, Settings, User } from "lucide-react"

interface HeaderProps {
  user: SuperAdminUser;
  notifications: Notification[];
  search: GlobalSearch;
  theme: 'light' | 'dark';
}


## 📱 MÓDULOS FUNCIONALES

> **✅ BACKEND YA IMPLEMENTADO:** Todas las APIs, servicios y base de datos están listos. Solo necesitamos crear la interfaz de usuario.

### **🏥 MÓDULO 1: DASHBOARD PRINCIPAL**

#### **1.1 Dashboard Ejecutivo**
**Como Superadministrador CAPI, quiero ver un dashboard con métricas clave para tomar decisiones informadas rápidamente.**

**Componentes principales:**
- **Header:** Título, descripción, botones de exportar y actualizar
- **Métricas principales:** 4 cards con KPIs (Usuarios Activos, Clínicas, Consultas, Score Compliance)
- **Gráficos:** Usuarios activos (30 días) y consultas por clínica
- **Alertas:** Sistema de notificaciones con prioridades

#### **1.2 Componentes UI Específicos**
- **Gráficos Recharts:** LineChart para usuarios activos con colores CAPI
- **Cards de Métricas:** Con iconos, valores, cambios porcentuales y descripciones
- **Lista de Alertas:** Con prioridades visuales (critical, high, medium, low)
- **Responsive Grid:** Layout adaptativo para diferentes pantallas

### **🔒 MÓDULO 2: AUDITORÍA Y TRAZABILIDAD**

#### **2.1 Auditoría Completa**
**Como Auditor COFEPRIS, quiero ver todos los logs de auditoría con filtros avanzados para verificar el cumplimiento y detectar anomalías.**

**Componentes principales:**
- **Header:** Título, descripción, botones de exportar (PDF/Excel) y actualizar
- **Filtros avanzados:** Por fecha, usuario, acción, recurso, clínica, resultado
- **Métricas:** Total eventos, usuarios únicos, eventos de seguridad, score compliance
- **Tabla de logs:** Con paginación, ordenamiento y modal de detalles

#### **2.2 Componentes UI de Auditoría**
- **Tabla de Logs:** Con avatares, badges de estado, fechas formateadas
- **Modal de Detalles:** Información completa del evento (usuario, cambios, IP, user agent)
- **Filtros Dinámicos:** MultiSelect para usuarios, acciones, recursos, clínicas
- **Exportación:** PDF y Excel con datos filtrados

### **📋 MÓDULO 3: CUMPLIMIENTO COFEPRIS**

#### **3.1 Dashboard de Compliance**
**Como Auditor COFEPRIS, quiero ver el estado de cumplimiento en tiempo real para verificar que CAPI cumple con todas las normativas.**

**Componentes principales:**
- **Score Principal:** Card destacado con 98.5% de cumplimiento COFEPRIS
- **Métricas:** Solicitudes ARCO, tiempo de respuesta, consentimientos, datos retenidos
- **Requisitos COFEPRIS:** Lista con estados visuales (cumple/pendiente)
- **Próximas Auditorías:** Calendario de auditorías programadas

#### **3.2 Gestión de Derechos ARCO**
**Como Administrador CAPI, quiero gestionar las solicitudes de derechos ARCO para cumplir con la LFPDPPP y responder a usuarios.**

**Componentes principales:**
- **Filtros:** Por estado, fecha, derechos solicitados
- **Métricas ARCO:** Pendientes, completadas, tiempo promedio, score cumplimiento
- **Tabla de Solicitudes:** Con avatares, badges de estado, tiempos de respuesta
- **Acciones:** Exportar, nueva solicitud, procesar solicitudes

### **👥 MÓDULO 4: GESTIÓN DE USUARIOS**

#### **4.1 Administración de Usuarios**
**Como Superadministrador CAPI, quiero gestionar usuarios, roles y permisos para controlar el acceso al sistema.**

**Funcionalidades principales:**
- **CRUD de Usuarios:** Crear, editar, eliminar, suspender usuarios
- **Gestión de Roles:** Asignación y modificación de roles (Doctor, Asistente, Paciente, Admin)
- **Permisos Granulares:** Configuración detallada de permisos por módulo
- **Gestión de Clínicas:** Asociación usuario-clínica
- **Invitations:** Envío de invitaciones por email
- **Bulk Operations:** Operaciones masivas sobre usuarios

#### **4.2 Seguridad de Usuarios**
- **Historial de Login:** Intentos de acceso, IPs, dispositivos
- **Sesiones Activas:** Gestión de sesiones en tiempo real
- **Reset de Contraseñas:** Proceso administrativo
- **2FA Management:** Configuración de autenticación de dos factores

### **🏥 MÓDULO 5: GESTIÓN DE CLÍNICAS**

#### **5.1 Información de Clínicas**
**Como Superadministrador CAPI, quiero gestionar clínicas y sus configuraciones para optimizar el rendimiento del sistema.**

**Funcionalidades principales:**
- **Vista de Clínicas:** Cards con métricas por clínica
- **Métricas por Clínica:** Usuarios activos, consultas, ingresos, cumplimiento
- **Configuraciones:** Settings globales y por clínica
- **Integraciones:** APIs, webhooks, servicios externos
- **Backup Settings:** Configuración de respaldos

### **📊 MÓDULO 6: MÉTRICAS Y ANALYTICS**

#### **6.1 Analytics Avanzados**
**Como Superadministrador CAPI, quiero ver métricas de negocio y analytics avanzados para tomar decisiones estratégicas.**

**Funcionalidades principales:**
- **Métricas de Negocio:** Usuarios, consultas, ingresos, crecimiento, retención
- **Dashboards Personalizables:** Widgets drag & drop, filtros dinámicos
- **Comparaciones:** Períodos, clínicas, benchmarks
- **Alertas Personalizadas:** Notificaciones basadas en métricas
- **Reportes Automáticos:** Diarios, semanales, mensuales, anuales

### **🔧 MÓDULO 7: ADMINISTRACIÓN DEL SISTEMA**

#### **7.1 Monitoreo del Sistema**
**Como Superadministrador CAPI, quiero monitorear el sistema y gestionar configuraciones para mantener la estabilidad y rendimiento.**

**Funcionalidades principales:**
- **Health Monitoring:** Estado del sistema en tiempo real
- **Performance Metrics:** CPU, memoria, storage, rendimiento
- **Error Logs:** Errores de aplicación y base de datos
- **Backup Management:** Estado, configuración, restauración
- **Integration Status:** Estado de APIs externas
- **Configuraciones Globales:** Settings, API keys, webhooks, notificaciones

### **💳 MÓDULO 8: GESTIÓN DE PLANES Y SUSCRIPCIONES**

#### **8.1 Administración de Planes CAPI**
**Como Superadministrador CAPI, quiero gestionar los planes de suscripción, sus límites y días de prueba para controlar el acceso a la plataforma.**

**Funcionalidades principales:**
- **CRUD de Planes:** Crear, editar y eliminar planes (Starter, Premium, Elite, etc.).
- **Gestión de Límites:** Configurar límites de pacientes, personal y créditos IA. (Valor `0` = Ilimitado).
- **Control de Días de Prueba (Trial):** Asignar días de prueba gratuitos por plan.
- **Tipos de Planes:** Distinción entre planes públicos (visibles en la app) e internos (isPublic = false).
- **Asignación Manual a Clínicas:** Capacidad de otorgar planes gratuitos o ilimitados manualmente desde el panel.
  - El sistema desconecta internamente las validaciones de Stripe marcando `stripe_subscription_status = active`.
  - El panel limpia los IDs de Stripe para evitar confusiones futuras.
  - Alerta de seguridad si la clínica tenía suscripción Stripe activa para que el administrador la cancele manualmente.

---

## 🔐 SEGURIDAD Y COMPLIANCE

### **Autenticación y Autorización**
- **Firebase Auth:** Autenticación robusta con MFA
- **RBAC:** Autorización basada en roles
- **Permisos Granulares:** Configuración detallada por módulo
- **Auditoría Completa:** Logging de todas las acciones

### **Auditoría de Seguridad**
- **Login Attempts:** Intentos de acceso fallidos
- **Permission Changes:** Cambios en permisos
- **Data Access:** Acceso a datos sensibles
- **System Changes:** Modificaciones del sistema

### **Cumplimiento Legal**
- **LFPDPPP Compliance:** Cumplimiento con ley mexicana
- **COFEPRIS Compliance:** Cumplimiento con normativas médicas
- **Data Retention:** Políticas de retención de datos (5 años)
- **ARCO Rights:** Gestión de derechos de protección de datos

---

## 📱 EXPERIENCIA DE USUARIO

### **Responsive Design**
- **Mobile First:** Optimizado para dispositivos móviles
- **Tablet Support:** Interfaz adaptada para tablets
- **Desktop:** Experiencia completa en desktop

### **Accesibilidad**
- **WCAG 2.1 AA:** Cumplimiento con estándares de accesibilidad
- **Keyboard Navigation:** Navegación completa por teclado
- **Screen Reader Support:** Compatibilidad con lectores de pantalla
- **High Contrast:** Modo de alto contraste

### **Performance**
- **Loading Time:** < 3 segundos para carga inicial
- **Real-time Updates:** Actualizaciones en tiempo real
- **Caching:** Estrategias de caché inteligente

---

## 🚀 ROADMAP DE DESARROLLO

> **✅ BACKEND COMPLETO:** Todas las APIs, servicios, base de datos y lógica de negocio están implementados. Solo necesitamos crear la interfaz de usuario.

### **Fase 1: MVP UI (2 semanas)**
- 🎨 **Dashboard Principal:** Métricas en tiempo real con shadcn/ui
- 🎨 **Módulo de Auditoría:** Tablas, filtros y visualizaciones
- 🎨 **Autenticación UI:** Login, permisos y navegación
- 🎨 **Layout Base:** Header, sidebar, responsive design

### **Fase 2: Compliance UI (2 semanas)**
- 🎨 **Dashboard COFEPRIS:** Score de cumplimiento y requisitos
- 🎨 **Gestión ARCO:** Tabla de solicitudes, filtros, estados
- 🎨 **Reportes UI:** Generación y exportación de reportes
- 🎨 **Políticas UI:** Gestión de consentimientos y privacidad

### **Fase 3: Analytics UI (2 semanas)**
- 🎨 **Gráficos Avanzados:** Recharts con datos en tiempo real
- 🎨 **Dashboards Personalizables:** Drag & drop widgets
- 🎨 **Métricas de Negocio:** KPIs y tendencias
- 🎨 **Alertas UI:** Sistema de notificaciones visual

### **Fase 4: Administración UI (1 semana)**
- 🎨 **Monitoreo Sistema:** Health checks y performance
- 🎨 **Gestión Backups:** Estado y configuración
- 🎨 **Configuraciones:** Settings globales y por clínica
- 🎨 **Integraciones:** APIs y webhooks management

---

## 📊 MÉTRICAS DE ÉXITO

### **Métricas Técnicas**
- **Uptime:** 99.9% de disponibilidad
- **Performance:** < 3s tiempo de carga
- **Security:** 0 incidentes de seguridad
- **Compliance:** 100% cumplimiento COFEPRIS

### **Métricas de Negocio**
- **User Adoption:** 90% de usuarios activos
- **Task Completion:** 95% de tareas completadas
- **User Satisfaction:** 4.5/5 rating
- **Time to Value:** < 1 día para primeros insights

### **Métricas de Compliance**
- **Audit Readiness:** 100% preparado para auditorías
- **Data Retention:** 100% cumplimiento de políticas
- **ARCO Response:** < 20 días tiempo de respuesta
- **Security Score:** 95+ puntos de seguridad

---

## 🛠️ IMPLEMENTACIÓN TÉCNICA

### **Estructura del Proyecto**
```
src/
├── components/          # Componentes reutilizables
├── modules/            # Módulos funcionales
├── services/           # Servicios de API
├── hooks/              # Custom hooks
├── utils/              # Utilidades
├── types/              # Tipos TypeScript
├── store/              # Estado global
└── assets/             # Recursos estáticos
```

### **Integración con CAPI**
```typescript
// Conexión a la base de datos existente
const firebaseConfig = {
  // Misma configuración que CAPI
  projectId: 'capideveloper-6078c',
  // ... resto de configuración
};

// Servicios compartidos
const auditService = new AuditService(firestore);
const metricsService = new MetricsService(firestore);
const complianceService = new ComplianceService(firestore);
```

### **API Endpoints**
```typescript
// Endpoints principales
/api/dashboard/metrics
/api/audit/logs
/api/compliance/status
/api/users/management
/api/clinics/overview
/api/system/health
```

---

## 📋 CRITERIOS DE ACEPTACIÓN

### **🎨 Diseño y UI/UX**
- [ ] **Sistema de Diseño CAPI:** Colores, tipografía y espaciado consistentes
- [ ] **shadcn/ui Components:** Todos los componentes usando la librería
- [ ] **Responsive Design:** Mobile-first, tablet y desktop optimizado
- [ ] **Dark/Light Mode:** Tema completo con toggle funcional
- [ ] **Accesibilidad WCAG 2.1 AA:** Navegación por teclado, screen readers
- [ ] **Iconografía Lucide:** Iconos consistentes en toda la aplicación

### **📊 Dashboard y Métricas**
- [ ] **Dashboard Principal:** 4 métricas principales con gráficos
- [ ] **Gráficos Recharts:** Usuarios activos, consultas, eventos de auditoría
- [ ] **Cards de Métricas:** Con tendencias y cambios porcentuales
- [ ] **Alertas Visuales:** Sistema de notificaciones con prioridades
- [ ] **Tiempo Real:** Actualizaciones automáticas cada 30 segundos

### **🔍 Auditoría y Filtros**
- [ ] **Tabla de Auditoría:** Con paginación y ordenamiento
- [ ] **Filtros Avanzados:** Por usuario, acción, recurso, fecha, resultado
- [ ] **Modal de Detalles:** Información completa de cada evento
- [ ] **Exportación:** PDF y Excel con datos filtrados
- [ ] **Búsqueda Global:** En header con resultados instantáneos

### **📋 Cumplimiento COFEPRIS**
- [ ] **Score de Cumplimiento:** Card principal con 98.5% score
- [ ] **Requisitos COFEPRIS:** Lista con estados visuales
- [ ] **Gestión ARCO:** Tabla de solicitudes con filtros
- [ ] **Estados ARCO:** Badges de colores para cada estado
- [ ] **Reportes de Compliance:** Generación automática

### **👥 Gestión de Usuarios**
- [ ] **Tabla de Usuarios:** Con avatares, roles y estados
- [ ] **Filtros de Usuario:** Por rol, clínica, estado de actividad
- [ ] **Modal de Usuario:** Crear, editar, ver detalles
- [ ] **Gestión de Roles:** Asignación visual de permisos
- [ ] **Bulk Operations:** Selección múltiple y acciones masivas

### **🏥 Gestión de Clínicas**
- [ ] **Vista de Clínicas:** Cards con métricas por clínica
- [ ] **Métricas por Clínica:** Usuarios, consultas, ingresos
- [ ] **Configuraciones:** Settings globales y por clínica
- [ ] **Integraciones:** APIs y webhooks management

### **📈 Analytics y Reportes**
- [ ] **Gráficos Interactivos:** Recharts con tooltips y zoom
- [ ] **Dashboards Personalizables:** Drag & drop widgets
- [ ] **Filtros Dinámicos:** Por fecha, clínica, usuario
- [ ] **Exportación de Datos:** Múltiples formatos
- [ ] **Comparaciones:** Períodos, clínicas, benchmarks

### **🔧 Administración del Sistema**
- [ ] **Health Monitoring:** Estado del sistema en tiempo real
- [ ] **Backup Status:** Estado y configuración de respaldos
- [ ] **Error Logs:** Visualización de errores del sistema
- [ ] **Performance Metrics:** CPU, memoria, storage
- [ ] **Integration Status:** Estado de APIs externas

### **⚡ Performance y Técnico**
- [ ] **Carga Inicial:** < 3 segundos con loading states
- [ ] **Navegación:** Transiciones suaves entre páginas
- [ ] **Caching:** Datos en caché para mejor performance
- [ ] **Lazy Loading:** Componentes cargados bajo demanda
- [ ] **Error Handling:** Estados de error y retry automático

### **📱 Responsive y Accesibilidad**
- [ ] **Mobile Layout:** Sidebar colapsable, navegación táctil
- [ ] **Tablet Layout:** Grid adaptativo, componentes optimizados
- [ ] **Desktop Layout:** Sidebar fijo, múltiples columnas
- [ ] **Keyboard Navigation:** Tab, Enter, Escape, flechas
- [ ] **Screen Reader:** ARIA labels y roles apropiados
- [ ] **High Contrast:** Modo de alto contraste disponible

---

## 🚀 INSTRUCCIONES PARA LOVABLE.DEV

### **Configuración Inicial del Proyecto**

#### **1. Setup del Proyecto**
```bash
# Crear proyecto React con TypeScript
npx create-react-app capi-admin --template typescript
cd capi-admin

# Instalar shadcn/ui
npx shadcn-ui@latest init

# Instalar dependencias principales
npm install @radix-ui/react-avatar @radix-ui/react-dialog @radix-ui/react-dropdown-menu
npm install @radix-ui/react-select @radix-ui/react-separator @radix-ui/react-tabs
npm install @radix-ui/react-toast @radix-ui/react-tooltip
npm install recharts lucide-react date-fns
npm install zustand @tanstack/react-query
npm install firebase
```

#### **2. Configuración de Firebase**
```typescript
// src/lib/firebase.ts
import { initializeApp } from 'firebase/app'
import { getFirestore } from 'firebase/firestore'
import { getAuth } from 'firebase/auth'

const firebaseConfig = {
  projectId: 'capideveloper-6078c',
  // ... resto de configuración (misma que CAPI)
}

export const app = initializeApp(firebaseConfig)
export const db = getFirestore(app)
export const auth = getAuth(app)
```

#### **3. Estructura de Carpetas**
```
src/
├── components/
│   ├── ui/                 # shadcn/ui components
│   ├── layout/             # Header, Sidebar, Layout
│   ├── dashboard/          # Dashboard components
│   ├── audit/              # Audit components
│   ├── compliance/          # COFEPRIS components
│   ├── users/              # User management
│   ├── clinics/            # Clinic management
│   └── analytics/           # Analytics components
├── pages/                  # Page components
├── hooks/                  # Custom hooks
├── services/               # API services
├── store/                  # Zustand store
├── types/                  # TypeScript types
├── lib/                    # Utilities
└── styles/                 # Global styles
```

#### **4. Configuración de Tema CAPI**
```typescript
// src/lib/theme.ts
export const capiTheme = {
  colors: {
    primary: '#0EADE0',        // Azul CAPI principal
    secondary: '#0A7188',      // Azul CAPI secundario
    accent: '#F33131',         // Rojo CAPI
    success: '#02CA79',        // Verde CAPI
    warning: '#C96F46',        // Naranja CAPI
    error: '#E65454',          // Rojo error CAPI
    info: '#0EADE0',           // Info = Primary
    muted: '#F0F1F1',         // Fondo gris CAPI
    border: '#E0E3E7'         // Border CAPI
  },
  fonts: {
    heading: 'Outfit, sans-serif',
    body: 'Inter, sans-serif',
    mono: 'JetBrains Mono, monospace'
  }
}
```

### **Componentes Críticos a Implementar**

#### **1. Layout Principal**
- **AdminLayout:** Header, Sidebar, contenido principal
- **Header:** Logo CAPI, búsqueda global, notificaciones, usuario
- **Sidebar:** Navegación con iconos, badges, estado del sistema
- **Responsive:** Mobile-first, sidebar colapsable

#### **2. Dashboard Principal**
- **Header:** Título, descripción, botones de acción
- **Métricas:** 4 cards con KPIs principales
- **Gráficos:** Recharts con datos en tiempo real
- **Alertas:** Sistema de notificaciones

#### **3. Servicios de API**
- **Dashboard Metrics:** Métricas en tiempo real
- **Audit Logs:** Logs con filtros avanzados
- **ARCO Requests:** Gestión de solicitudes
- **User Management:** CRUD de usuarios

### **Datos Mock para Desarrollo**

#### **1. Métricas de Dashboard**
- **Total Users:** 2,847 usuarios activos
- **Active Clinics:** 23 clínicas registradas
- **Consultations Today:** 156 consultas hoy
- **Compliance Score:** 98.5% cumplimiento COFEPRIS

#### **2. Logs de Auditoría**
- **Eventos de muestra:** CREATE_CONSULTATION, UPDATE_USER, LOGIN, etc.
- **Usuarios:** Dr. García, María López, Admin CAPI
- **Estados:** success, failure, pending
- **Recursos:** Consulta, Usuario, Configuración

#### **3. Solicitudes ARCO**
- **Derechos:** Acceso, Rectificación, Cancelación, Oposición
- **Estados:** pending, in-progress, completed, rejected
- **Usuarios:** María López, Juan Pérez, Ana García
- **Tiempos:** Respuesta promedio 5-15 días

### **Configuración de Desarrollo**

#### **1. Variables de Entorno**
- **Firebase Project ID:** capideveloper-6078c
- **Firebase API Key:** Configurar en .env.local
- **Firebase Auth Domain:** capideveloper-6078c.firebaseapp.com
- **Firebase Storage Bucket:** capideveloper-6078c.appspot.com

#### **2. Scripts de Desarrollo**
- **dev:** react-scripts start (desarrollo)
- **build:** react-scripts build (producción)
- **test:** react-scripts test (testing)
- **eject:** react-scripts eject (ejectar configuración)

### **Prioridades de Implementación**

#### **Semana 1: Base y Dashboard**
1. ✅ Setup del proyecto con shadcn/ui
2. ✅ Configuración de Firebase
3. ✅ Layout principal (Header, Sidebar)
4. ✅ Dashboard con métricas básicas
5. ✅ Gráficos con Recharts

#### **Semana 2: Auditoría y Compliance**
1. ✅ Página de auditoría con filtros
2. ✅ Tabla de logs con paginación
3. ✅ Dashboard de compliance COFEPRIS
4. ✅ Gestión de solicitudes ARCO
5. ✅ Modal de detalles

#### **Semana 3: Gestión y Analytics**
1. ✅ Gestión de usuarios
2. ✅ Gestión de clínicas
3. ✅ Analytics avanzados
4. ✅ Reportes y exportación
5. ✅ Configuraciones del sistema

#### **Semana 4: Polish y Deploy**
1. ✅ Responsive design completo
2. ✅ Dark/light mode
3. ✅ Accesibilidad
4. ✅ Performance optimization
5. ✅ Deploy a Vercel

---

## 📞 CONTACTO Y SOPORTE

**Equipo de Desarrollo CAPI**  
**Email:** dev@capi.com  
**Documentación:** [docs.capi.com](https://docs.capi.com)  
**Soporte:** [support.capi.com](https://support.capi.com)  

---

**Versión del PRD:** 1.0  
**Fecha de creación:** Diciembre 2024  
**Próxima revisión:** Enero 2025  
**Estado:** Aprobado para desarrollo  

---

*Este PRD define los requerimientos completos para el desarrollo del Panel Administrativo CAPI, incluyendo todas las funcionalidades necesarias para cumplimiento COFEPRIS, auditoría integral y administración del sistema. El backend ya está implementado, solo necesitamos crear la interfaz de usuario con shadcn/ui.*
