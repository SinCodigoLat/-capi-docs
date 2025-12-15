# Implementación de Campos de Auditoría

## Campos Requeridos

Cada documento en Firestore debe incluir los siguientes campos de auditoría:

### Campos Obligatorios
- `createdBy`: String (UID del usuario que creó el documento)
- `createdDate`: Timestamp (fecha y hora de creación)
- `modifiedBy`: String (UID del usuario que modificó por última vez)
- `modifiedDate`: Timestamp (fecha y hora de la última modificación)
- `actionType`: String (tipo de acción: 'CREATE', 'UPDATE', 'DELETE')

## Funciones Helper para Dart/Flutter

### 1. Función para Crear Documentos

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> addAuditFieldsForCreate(
  Map<String, dynamic> data,
  String userId,
) {
  final now = Timestamp.now();
  
  return {
    ...data,
    'createdBy': userId,
    'createdDate': now,
    'modifiedBy': userId,
    'modifiedDate': now,
    'actionType': 'CREATE',
  };
}
```

### 2. Función para Actualizar Documentos

```dart
Map<String, dynamic> addAuditFieldsForUpdate(
  Map<String, dynamic> data,
  String userId,
) {
  return {
    ...data,
    'modifiedBy': userId,
    'modifiedDate': Timestamp.now(),
    'actionType': 'UPDATE',
  };
}
```

### 3. Función para Eliminar Documentos

```dart
Map<String, dynamic> addAuditFieldsForDelete(String userId) {
  return {
    'modifiedBy': userId,
    'modifiedDate': Timestamp.now(),
    'actionType': 'DELETE',
  };
}
```

## Ejemplos de Uso

### Crear Usuario
```dart
final userData = {
  'name': 'Juan Pérez',
  'email': 'juan@example.com',
  'role': 'patient',
};

final userDataWithAudit = addAuditFieldsForCreate(
  userData,
  FirebaseAuth.instance.currentUser!.uid,
);

await FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .set(userDataWithAudit);
```

### Actualizar Usuario
```dart
final updateData = {
  'name': 'Juan Carlos Pérez',
};

final updateDataWithAudit = addAuditFieldsForUpdate(
  updateData,
  FirebaseAuth.instance.currentUser!.uid,
);

await FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .update(updateDataWithAudit);
```

### Eliminar Usuario (Soft Delete)
```dart
final deleteData = addAuditFieldsForDelete(
  FirebaseAuth.instance.currentUser!.uid,
);

await FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .update({
    ...deleteData,
    'deleted': true,
  });
```

## Reglas de Firestore Actualizadas

Las reglas de Firestore han sido actualizadas para validar automáticamente la presencia y validez de estos campos:

- `hasValidCreateAuditFields()`: Valida campos para creación
- `hasValidUpdateAuditFields()`: Valida campos para actualización
- `hasValidAuditFields()`: Validación general

## Migración de Datos Existentes

Para documentos existentes, se debe ejecutar un script de migración que agregue estos campos con valores por defecto.

## Consideraciones Importantes

1. **Performance**: Los campos de auditoría agregan overhead mínimo
2. **Seguridad**: Las reglas de Firestore validan automáticamente estos campos
3. **Auditoría**: Permite rastrear todos los cambios en la base de datos
4. **Compliance**: Cumple con requerimientos de auditoría médica

## Implementación en FlutterFlow

En FlutterFlow, estas funciones deben implementarse como Custom Actions para ser reutilizables en toda la aplicación.
