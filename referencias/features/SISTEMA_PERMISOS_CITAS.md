# 🔒 SISTEMA DE PERMISOS DE CITAS - IMPLEMENTACIÓN

**Fecha de implementación:** 28 de Octubre, 2025  
**Estado:** ✅ IMPLEMENTADO

---

## 🎯 OBJETIVO

Implementar control de acceso granular para que cada usuario solo pueda ver y gestionar las citas que le corresponden según su rol, cumpliendo con normativas de privacidad médica (COFEPRIS).

---

## 📋 REGLAS DE ACCESO POR ROL

### 👨‍⚕️ **PACIENTE**
- ✅ **Solo puede ver:** Sus propias citas (donde él es el paciente)
- ✅ **Acciones permitidas:**
	- Ver detalles de sus citas
	- Solicitar nueva cita
	- Cancelar sus citas (según políticas)
- ❌ **No puede ver:** Citas de otros pacientes

**Implementación:**
```dart
case 'Paciente':
	return allAppointments.where((cita) {
		return cita.paciente?.id == userUid;
	}).toList();
```

### 👨‍⚕️ **DOCTOR (Regular)**
- ✅ **Solo puede ver:** Sus propias citas (donde él es el doctor asignado)
- ✅ **Acciones permitidas:**
	- Ver detalles de sus pacientes
	- Gestionar sus consultas
	- Editar sus citas
- ❌ **No puede ver:** Citas de otros doctores

**Implementación:**
```dart
case 'Doctor':
	if (isAdmin) {
		// Doctor admin ve todas las citas de la clínica
		return allAppointments.where((cita) {
			return cita.clinica?.id == currentUser.clinica?.id;
		}).toList();
	}
	// Doctor regular: solo sus propias citas
	return allAppointments.where((cita) {
		return cita.doctor?.id == userUid;
	}).toList();
```

### 👨‍⚕️ **DOCTOR ADMIN / PROPIETARIO**
- ✅ **Puede ver:** TODAS las citas de la clínica
- ✅ **Acciones permitidas:**
	- Control total de gestión
	- Ver citas de todos los doctores
	- Gestionar equipo
	- Reportes y estadísticas
- ✅ **Identificación:** `role: 'Doctor' + isAdmin: true`

### 👥 **ASISTENTE (Con Permisos)**
- ✅ **Puede ver:** Todas las citas de la clínica (si tiene permisos)
- ✅ **Acciones permitidas:**
	- Gestionar agenda de la clínica
	- Crear/editar citas
	- Ver información de pacientes
- ⚠️ **Requiere:** `isAdmin: true` O `permisos.verCitas: true` O `permisos.todos: true`

**Implementación:**
```dart
case 'Asistente':
	if (isAdmin || 
		currentUser.permisos.todos == true || 
		currentUser.permisos.verCitas == true) {
		return allAppointments.where((cita) {
			return cita.clinica?.id == currentUser.clinica?.id;
		}).toList();
	}
	// Asistente sin permisos: sin acceso
	return [];
```

### 👥 **ASISTENTE (Sin Permisos)**
- ❌ **No puede ver:** Ninguna cita
- ⚠️ **Requiere:** Asignación explícita de permisos por el administrador

---

## 🛠️ FUNCIONES IMPLEMENTADAS

### 1. **filterAppointmentsByRole()**
**Ubicación:** `lib/flutter_flow/custom_functions.dart`

Filtra la lista completa de citas según el rol del usuario actual.

```dart
List<CitasRecord> filterAppointmentsByRole(
	List<CitasRecord> allAppointments,
	UsersRecord? currentUser,
)
```

**Parámetros:**
- `allAppointments`: Lista completa de citas a filtrar
- `currentUser`: Usuario actual (con rol y permisos)

**Retorno:**
- Lista filtrada de citas según permisos del usuario

### 2. **canViewAppointment()**
**Ubicación:** `lib/flutter_flow/custom_functions.dart`

Verifica si un usuario específico puede ver una cita específica.

```dart
bool canViewAppointment(
	CitasRecord appointment,
	UsersRecord? currentUser,
)
```

**Uso:** Validaciones individuales antes de mostrar detalles

### 3. **getNoAppointmentsMessage()**
**Ubicación:** `lib/flutter_flow/custom_functions.dart`

Retorna mensaje personalizado cuando no hay citas disponibles.

```dart
String getNoAppointmentsMessage(UsersRecord? currentUser)
```

**Retorno:**
- Paciente: "No tienes citas agendadas"
- Doctor: "No tienes citas asignadas"
- Asistente: "No hay citas en la clínica"

---

## 📍 ARCHIVOS MODIFICADOS

### ✅ Funciones Base
- ✅ `lib/flutter_flow/custom_functions.dart`
	- `filterAppointmentsByRole()` - Filtrado por rol
	- `filterAppointmentsByDoctor()` - Filtrado por doctor específico
	- `canViewAppointment()` - Validación individual
	- `canViewMultipleDoctorsAppointments()` - Verificar permisos múltiples
	- `getNoAppointmentsMessage()` - Mensajes personalizados

### ✅ Estado de Aplicación
- ✅ `lib/app_state.dart`
	- `selectedDoctorFilter` - Estado del filtro por doctor

### ✅ Calendario
- ✅ `lib/clinica/menu_principal/calendario/calendario_widget.dart`
	- Aplicado filtro por rol en CustomCalendar
	- Dropdown de selección de doctor (solo para admins/asistentes)
	- Query modificado para traer todos los doctores de la clínica
	- Filtro combinado: rol + doctor específico

### ✅ Tablas de Citas
- ✅ `lib/componentes/tabla_cita_asistente/tabla_cita_asistente_widget.dart`
	- Filtrado de citas en tabla de asistente

### ⏳ Pendientes de Actualizar
- 🔄 `lib/componentes/tabla_cita/tabla_cita_widget.dart` (ya filtra por doctor)
- 🔄 `lib/componentes/tabla_cita/tabla_cita_new_widget.dart` (ya filtra por doctor)
- 🔄 `lib/componentes/tabla_consultas/tabla_consultas_widget.dart`
- 🔄 `lib/componentes/tabla_consultas_moderna/tabla_consultas_moderna_widget.dart`

---

## 🔐 SEGURIDAD ADICIONAL

### Firestore Rules
Las reglas de Firestore también validan acceso a nivel de base de datos:

```javascript
// Citas - Solo accesible por doctor asignado, paciente o admin de la clínica
match /citas/{citaId} {
	allow read: if isOwner(resource.data.paciente) || 
		isOwner(resource.data.doctor) || 
		(belongsToSameClinic(resource.data.clinica) && hasPermission('verTodasCitas'));
}
```

### Validación en Múltiples Capas
1. **UI:** Filtrado en la interfaz usando `filterAppointmentsByRole()`
2. **Backend:** Validación en Firestore Rules
3. **Queries:** Filtros directos en las consultas donde sea posible

---

## 📊 BENEFICIOS

✅ **Privacidad médica** cumple con normativas COFEPRIS
✅ **Escalabilidad** fácil agregar nuevos roles
✅ **Flexibilidad** permisos granulares por usuario
✅ **Seguridad** validación en múltiples capas
✅ **Experiencia de usuario** cada usuario ve solo lo relevante
✅ **Performance** filtrado eficiente con validaciones O(1)

---

## 🧪 TESTING

### Casos de Prueba

**Paciente:**
1. ✅ Solo ve sus propias citas
2. ✅ No puede acceder a citas de otros pacientes
3. ✅ Puede ver detalles de sus citas

**Doctor Regular:**
1. ✅ Solo ve citas donde es el doctor asignado
2. ✅ No puede ver citas de otros doctores
3. ✅ Puede gestionar sus propias citas

**Doctor Admin:**
1. ✅ Ve todas las citas de la clínica
2. ✅ Puede gestionar cualquier cita
3. ✅ Acceso completo a reportes

**Asistente con Permisos:**
1. ✅ Ve todas las citas de la clínica
2. ✅ Puede crear/editar citas
3. ✅ Acceso según permisos asignados

**Asistente sin Permisos:**
1. ✅ No ve ninguna cita
2. ✅ Requiere asignación de permisos

---

## 🎛️ FILTRO POR DOCTOR

### **Funcionalidad Implementada**

Para usuarios que pueden ver citas de múltiples doctores (admins/propietarios/asistentes con permisos), se ha implementado un filtro adicional por doctor:

**Características:**
- ✅ Dropdown visible solo para usuarios con permisos múltiples
- ✅ Opción "Todos los doctores" por defecto
- ✅ Lista de todos los doctores de la clínica
- ✅ Filtro se mantiene al cambiar de vista (día/semana/mes)
- ✅ Se combina con el filtro de rol existente

**Lógica de Filtrado:**
```dart
// Paso 1: Filtrar por rol del usuario
final citasPorRol = functions.filterAppointmentsByRole(
  todasLasCitas,
  currentUserDocument
);

// Paso 2: Filtrar por doctor seleccionado (si aplica)
final citasFinales = functions.filterAppointmentsByDoctor(
  citasPorRol,
  FFAppState().selectedDoctorFilter  // 'todos' o UID del doctor
);
```

**Funciones Relacionadas:**
- `filterAppointmentsByDoctor()` - Aplica filtro por doctor
- `canViewMultipleDoctorsAppointments()` - Verifica si mostrar filtro

---

## 📝 NOTAS IMPORTANTES

⚠️ **Al crear nuevas vistas que muestren citas:**
1. Importar: `import '/flutter_flow/custom_functions.dart' as functions;`
2. Aplicar filtros en orden:
   ```dart
   // Primero filtrar por rol
   final citasPorRol = functions.filterAppointmentsByRole(
     citasList, 
     currentUserDocument
   );
   
   // Luego filtrar por doctor (opcional)
   final citasFinales = functions.filterAppointmentsByDoctor(
     citasPorRol,
     FFAppState().selectedDoctorFilter
   );
   ```
3. Validar permisos antes de mostrar detalles
4. Mostrar filtro de doctor solo si `functions.canViewMultipleDoctorsAppointments(currentUserDocument)` retorna `true`

⚠️ **Consistencia con el modelo:**
- Admin siempre tiene `role: 'Doctor' + isAdmin: true`
- Nunca usar `role: 'Administrador'`
- Validar `isAdmin` antes de `permisos.verCitas`

---

## 🔄 PRÓXIMOS PASOS

### Fase 2: Consultas
- [ ] Aplicar mismo sistema a consultas médicas
- [ ] Filtrar expedientes por rol
- [ ] Validar acceso a documentos médicos

### Fase 3: Reportes
- [ ] Filtrar estadísticas por rol
- [ ] Generar reportes según permisos
- [ ] Dashboard personalizado por rol

### Fase 4: Auditoría
- [ ] Registrar accesos a citas
- [ ] Log de cambios por usuario
- [ ] Trazabilidad completa

---

**Implementado por:** Sistema de Permisos CAPI  
**Versión:** 1.0  
**Última actualización:** 28 de Octubre, 2025

