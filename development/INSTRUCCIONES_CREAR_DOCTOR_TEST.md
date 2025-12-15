# Instrucciones para Crear Doctor de Prueba

## Opción 1: Firebase Console (Recomendado)

1. Ve a [Firebase Console](https://console.firebase.google.com/project/capideveloper-6078c/firestore)
2. Navega a Firestore Database
3. Ve a la colección `users`
4. Haz clic en "Add document"
5. Usa el ID: `test_doctor_123`
6. Copia y pega el siguiente JSON en el documento:

```json
{
  "email": "doctor.test@capi.com",
  "display_name": "Dr. Juan Carlos Test",
  "photo_url": "",
  "uid": "test_doctor_123",
  "created_time": "2025-09-15T22:47:19.231Z",
  "phone_number": "+52 81 1234 5678",
  "shortDescription": "Doctor de prueba para testing",
  "last_active_time": "2025-09-15T22:47:19.237Z",
  "role": "Doctor",
  "title": "Dr.",
  "nombre": "Juan Carlos",
  "apellidoPaterno": "Test",
  "apellidoMaterno": "Doctor",
  "fechaNacimiento": "1985-06-15T00:00:00.000Z",
  "estadoCivil": "Soltero",
  "ocupacion": "Médico General",
  "notas": "Doctor de prueba para testing de la aplicación",
  "otroTelefono": "",
  "genero": "Masculino",
  "direccion": {
    "estado": "Nuevo León",
    "callePrincipal": "Av. Universidad 123",
    "ciudad": "Monterrey",
    "codigo_zip": "64000",
    "calleSecundaria": "Col. Centro",
    "pais": "México"
  },
  "longDescription": "Doctor de prueba especializado en medicina general con más de 10 años de experiencia.",
  "isAdmin": false,
  "religion": "Católico",
  "lugarOrigen": "Monterrey, N.L.",
  "lugarResidencia": "Monterrey, N.L.",
  "referidoPor": "",
  "DNI": "TEST123456789",
  "tipoSangre": "O+",
  "seguroMedico": {
    "nombre": "IMSS",
    "numero": "1234567890"
  },
  "expediente": "EXP-TEST-001",
  "peso": 75.5,
  "talla": 175,
  "nacionalidad": "Mexicana",
  "completeProfile": true,
  "color": "#0eade0",
  "ICM": 24.7,
  "zoomAccountID": "test_zoom_123",
  "zoomClientID": "test_client_123",
  "zoomSecretID": "test_secret_123",
  "zoomLinkInstantaneo": "https://zoom.us/j/test123",
  "permisos": {
    "canCreateAppointments": true,
    "canViewPatients": true,
    "canEditProfile": true
  },
  "stripePk_key": "pk_test_123",
  "stripeSK_key": "sk_test_123",
  "configCompleta": true,
  "horarios": true,
  "servicios": true,
  "equipo": true,
  "zoom": true,
  "stripe": true,
  "clinicas": [
    "projects/capideveloper-6078c/databases/(default)/documents/clinica/0MAmYRHP57BYbjfCIsJ7"
  ],
  "pacientes": [],
  "serviciosList": [
    "projects/capideveloper-6078c/databases/(default)/documents/servicios/3PR0TBiTYlndAOgyFOeD"
  ],
  "especialidadList": [
    "projects/capideveloper-6078c/databases/(default)/documents/especialidad/DtvZ6oyAk2Netl4p3gQ6"
  ],
  "ciudad": "Monterrey",
  "mis_doctores": [],
  "blockList": [],
  "Solicitudes": [],
  "onboardingComplete": true,
  "credits_ai": 10,
  "StripeOAuthID": "acct_test_123",
  "seccioActualenMenu": "Citas",
  "etapaIncorporacion": "configuroNegocio_04",
  "notificationPreferences": {
    "email": true,
    "push": true,
    "sms": false
  },
  "aceptaTerminosCondiciones": true,
  "fechaAceptacionTerminos": "2025-09-15T22:47:19.237Z",
  "modifiedBy": null,
  "modifiedDate": "2025-09-15T22:47:19.237Z",
  "actionType": "CREATE",
  "availability": [
    {
      "dayofWeek": "Monday",
      "startTime": "2025-01-01T14:00:00.000Z",
      "endTime": "2025-01-01T22:00:00.000Z"
    },
    {
      "dayofWeek": "Tuesday",
      "startTime": "2025-01-01T14:00:00.000Z",
      "endTime": "2025-01-01T22:00:00.000Z"
    },
    {
      "dayofWeek": "Wednesday",
      "startTime": "2025-01-01T14:00:00.000Z",
      "endTime": "2025-01-01T22:00:00.000Z"
    },
    {
      "dayofWeek": "Thursday",
      "startTime": "2025-01-01T14:00:00.000Z",
      "endTime": "2025-01-01T22:00:00.000Z"
    },
    {
      "dayofWeek": "Friday",
      "startTime": "2025-01-01T14:00:00.000Z",
      "endTime": "2025-01-01T22:00:00.000Z"
    }
  ]
}
```

## Opción 2: Usando Flutter/Dart

Si prefieres crear el doctor programáticamente desde la aplicación Flutter, puedes usar este código:

```dart
// Crear doctor de prueba
final doctorRef = FirebaseFirestore.instance.collection('users').doc('test_doctor_123');

await doctorRef.set({
  'email': 'doctor.test@capi.com',
  'display_name': 'Dr. Juan Carlos Test',
  'role': 'Doctor',
  'uid': 'test_doctor_123',
  // ... resto de los campos del JSON anterior
});
```

## Datos del Doctor de Prueba

- **Email:** doctor.test@capi.com
- **Nombre:** Dr. Juan Carlos Test
- **UID:** test_doctor_123
- **Clínica:** Clinica Prueba
- **Especialidad:** MEDICINA GENERAL
- **Horarios:** Lunes a Viernes de 2:00 PM a 10:00 PM

## Verificación

Una vez creado el doctor, puedes verificar que existe ejecutando:

```bash
# En la terminal del proyecto
node -e "
const admin = require('firebase-admin');
// ... código para verificar el doctor
"
```

O simplemente ve a la consola de Firebase y verifica que el documento existe en la colección `users` con el ID `test_doctor_123`.
