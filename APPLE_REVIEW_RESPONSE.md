# Respuesta a Apple Review - Guideline 2.1

## App Tracking Transparency Permission Request Location

### Cómo encontrar la solicitud de permiso ATT en CAPI:

**Navegación paso a paso:**

1. **Abrir la aplicación CAPI**
2. **Tocar el ícono de menú** (☰) en la esquina superior izquierda
3. **Seleccionar "Perfil"** del menú lateral
4. **Desplazarse a la sección "Preferencias"**
5. **Tocar "Privacidad y Analítica"**

### Comportamiento del permiso:

**Primera solicitud (Estado: No determinado)**
- Al tocar "Privacidad y Analítica", se muestra un diálogo educativo que explica:
  - Para qué usamos los datos de seguimiento
  - Qué beneficios obtiene el usuario
  - Garantía de que no compartimos datos con terceros
- Después de que el usuario lea la información y toque "Permitir", aparece el prompt nativo de iOS para autorizar el tracking
- El usuario puede elegir "Permitir" o "No permitir"

**Si el permiso fue denegado previamente**
- La opción muestra el estado "Deshabilitado"
- Al tocar, se presenta un diálogo con instrucciones para habilitar el permiso en Ajustes de iOS
- Incluye un botón "Ir a Ajustes" que abre directamente: Ajustes → Privacidad → Rastreo → CAPI

**Si el permiso está autorizado**
- La opción muestra el estado "Activo" con un indicador visual verde
- Al tocar, se confirma que el seguimiento está habilitado
- Se ofrece opción para ir a Ajustes si desea modificarlo

### ¿Por qué no aparece automáticamente al iniciar?

Hemos implementado un enfoque centrado en el usuario que:
- No interrumpe la experiencia inicial de la app
- Permite que el usuario entienda el contexto antes de decidir
- Proporciona control total sobre sus preferencias de privacidad
- Aumenta la tasa de aceptación al ofrecer información clara

Esta implementación cumple con las directrices de Apple y proporciona una mejor experiencia de usuario.

### Para qué usamos el tracking:

CAPI utiliza Firebase Analytics para:
- **Mejorar la experiencia**: Identificar qué funcionalidades son más útiles
- **Detectar errores**: Rastrear y corregir problemas técnicos
- **Optimizar funcionalidades**: Mejorar recordatorios médicos y notificaciones
- **Analítica clínica**: Ayudar a los doctores a entender el uso de la plataforma

**Importante:** No usamos los datos para publicidad ni los compartimos con terceros para rastreo comercial.

### Información técnica:

- **Mensaje del permiso** (NSUserTrackingUsageDescription):
  > "CAPI utiliza datos de uso para mejorar la experiencia de la app, optimizar funcionalidades clínicas y personalizar recordatorios médicos. No compartimos tus datos con terceros ni los usamos para publicidad."

- **Versión de la app**: 2.0.0+6 (o superior)
- **iOS deployment target**: 14.0+
- **Framework utilizado**: app_tracking_transparency (^3.0.0)

### Testing en dispositivos iOS:

**Para probar en un dispositivo limpio:**
1. Instalar la app desde TestFlight
2. Completar el onboarding inicial
3. Navegar a: Menú → Perfil → Preferencias → Privacidad y Analítica
4. Tocar la opción para ver el diálogo educativo
5. Aceptar para ver el prompt nativo de iOS

**Para resetear el estado del permiso:**
- Ajustes → General → Transferir o Restablecer → Restablecer → Restablecer Ubicación y Privacidad
- O desinstalar completamente la app y reinstalar

### Capturas de pantalla:

Las capturas de pantalla del flujo se pueden proporcionar si son necesarias para la revisión.

---

**Contacto:**
Si necesitan más información o asistencia para probar el flujo, estoy disponible para una llamada de revisión (App Review Appointment).

**Fecha de respuesta:** Noviembre 2025





