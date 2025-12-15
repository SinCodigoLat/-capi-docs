# Implementación de Paginación y Ordenamiento en Lista de Citas

## Características Implementadas

### ✅ **Paginación**
- Navegación entre páginas con botones anterior/siguiente
- Números de página con indicador visual de página actual
- Selector de items por página (10, 15, 25, 50)
- Información de paginación (mostrando X de Y citas)

### ✅ **Ordenamiento por Columnas**
- **Paciente**: Ordena alfabéticamente por nombre del paciente
- **Fecha**: Ordena cronológicamente por fecha de cita
- **Estado**: Ordena alfabéticamente por estado de la cita
- **Servicio**: Ordena alfabéticamente por nombre del servicio
- **Precio**: Ordena numéricamente por precio

### ✅ **Búsqueda Avanzada**
- Búsqueda en tiempo real por nombre de paciente
- Búsqueda por email del paciente
- Filtrado automático con debounce

### ✅ **Funcionalidades Adicionales**
- Exportación a CSV
- Filtros por estado de cita
- Acciones por cita (editar, cancelar, eliminar)
- Estados de carga y error mejorados

## Archivos Creados

1. **`lib/custom_code/widgets/tabla_citas_paginada_widget.dart`** - Widget principal de tabla paginada
2. **`lib/custom_code/actions/busqueda_citas_avanzada.dart`** - Acciones para búsqueda y ordenamiento
3. **`lib/custom_code/widgets/ejemplo_uso_tabla_paginada.dart`** - Ejemplo de implementación

## Cómo Implementar

### Paso 1: Reemplazar StreamBuilder por FutureBuilder

**Antes (problemático):**
```dart
StreamBuilder<List<CitasRecord>>(
  stream: queryCitasRecord(...),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator(); // Se queda cargando indefinidamente
    }
    // ...
  },
)
```

**Después (optimizado):**
```dart
FutureBuilder<List<CitasRecord>>(
  future: buscarCitasAvanzada(
    userId: currentUserUid,
    userRole: currentUserDocument?.role ?? '',
    clinicaId: currentUserDocument?.clinica,
    estadoFiltro: FFAppState().mnuCitasInitOpt,
    limit: 200, // Para paginación
  ),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CitasLoadingWidget(message: 'Cargando citas...');
    }
    
    if (snapshot.hasError) {
      return CitasErrorWidget(
        message: 'Error al cargar citas',
        onRetry: () => setState(() {}),
      );
    }
    
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return CitasEmptyWidget(
        message: 'No hay citas disponibles',
        subtitle: 'Intenta cambiar los filtros',
      );
    }
    
    // Usar el widget de tabla paginada
    return TablaCitasPaginadaWidget(
      citas: snapshot.data!,
      itemsPerPage: 15,
      onCitaTap: (cita) {
        // Navegar a detalles de la cita
        context.pushNamed('DetallesCitaWidget', ...);
      },
      showActions: true,
    );
  },
)
```

### Paso 2: Usar el Widget de Tabla Paginada

```dart
// Widget completo con filtros y controles
EjemploUsoTablaPaginada()

// O solo la tabla si ya tienes las citas
TablaCitasSimple(
  citas: tuListaDeCitas,
  itemsPerPage: 15,
  onCitaTap: (cita) => tuFuncionDeNavegacion(cita),
)
```

### Paso 3: Configurar Búsqueda Avanzada

```dart
// En tu función de carga de citas
final citas = await buscarCitasAvanzada(
  userId: currentUserUid,
  userRole: currentUserDocument?.role ?? '',
  clinicaId: currentUserDocument?.clinica,
  estadoFiltro: estadoSeleccionado,
  searchTerm: terminoBusqueda,
  sortBy: columnaOrdenamiento,
  sortAscending: ordenAscendente,
  limit: 200,
);
```

## Características del Widget

### **Header de Tabla Interactivo**
- **Clic en títulos**: Cambia el ordenamiento
- **Iconos visuales**: Indican dirección del ordenamiento
- **Colores**: Resaltan la columna activa

### **Paginación Inteligente**
- **Navegación rápida**: Botones anterior/siguiente
- **Números de página**: Con indicador visual
- **Puntos suspensivos**: Para listas largas (ej: 1, 2, 3, ..., 10)
- **Información contextual**: "Mostrando X de Y citas"

### **Búsqueda en Tiempo Real**
- **Debounce automático**: Evita consultas excesivas
- **Búsqueda por nombre**: Incluye nombre y email del paciente
- **Filtrado local**: Para mejor rendimiento

### **Ordenamiento Avanzado**
- **Múltiples columnas**: Paciente, fecha, estado, servicio, precio
- **Orden ascendente/descendente**: Alterna con cada clic
- **Persistencia**: Mantiene el ordenamiento durante la sesión

## Personalización

### **Cambiar Items por Página**
```dart
TablaCitasPaginadaWidget(
  citas: citas,
  itemsPerPage: 25, // Cambiar de 15 a 25
  onCitaTap: onCitaTap,
  showActions: true,
)
```

### **Ocultar Columna de Acciones**
```dart
TablaCitasPaginadaWidget(
  citas: citas,
  itemsPerPage: 15,
  onCitaTap: onCitaTap,
  showActions: false, // Ocultar columna de acciones
)
```

### **Personalizar Callback de Cita**
```dart
TablaCitasPaginadaWidget(
  citas: citas,
  itemsPerPage: 15,
  onCitaTap: (cita) {
    // Tu lógica personalizada aquí
    print('Cita seleccionada: ${cita.reference.id}');
    // Navegar, mostrar modal, etc.
  },
  showActions: true,
)
```

## Funcionalidades de Exportación

### **Exportar a CSV**
```dart
Future<void> exportarCitas() async {
  try {
    final csvData = await exportarCitasCSV(citas: _citas);
    if (csvData.isNotEmpty) {
      // Implementar descarga del archivo
      // Por ejemplo, usando file_saver o similar
      print('CSV generado: ${csvData.length} caracteres');
    }
  } catch (e) {
    print('Error al exportar: $e');
  }
}
```

### **Obtener Estadísticas**
```dart
Future<void> obtenerEstadisticas() async {
  final stats = await obtenerEstadisticasCitas(
    userId: currentUserUid,
    userRole: currentUserDocument?.role ?? '',
    clinicaId: currentUserDocument?.clinica,
  );
  
  print('Total de citas: ${stats['totalCitas']}');
  print('Total de ingresos: \$${stats['totalIngresos']}');
  print('Estadísticas por estado: ${stats['estadisticasPorEstado']}');
}
```

## Beneficios de la Implementación

1. **Mejor Rendimiento**: No más cargas infinitas, paginación eficiente
2. **Experiencia de Usuario**: Navegación clara, ordenamiento intuitivo
3. **Escalabilidad**: Maneja listas grandes sin problemas de memoria
4. **Funcionalidad**: Búsqueda, ordenamiento, exportación en un solo lugar
5. **Mantenibilidad**: Código centralizado y reutilizable

## Consideraciones Técnicas

### **Límites de Firestore**
- Consultas limitadas a 200 resultados por defecto
- Ordenamiento por campos indexados para mejor rendimiento
- Filtrado local para búsquedas complejas

### **Manejo de Errores**
- Timeouts configurables (30 segundos por defecto)
- Reintentos automáticos con backoff exponencial
- Estados de error claros para el usuario

### **Optimizaciones**
- Cache local para datos frecuentemente accedidos
- Debounce en búsquedas para evitar consultas excesivas
- Lazy loading de datos de pacientes y servicios

## Próximos Pasos Recomendados

1. **Implementar en todas las páginas de citas** que usen StreamBuilder
2. **Agregar más filtros** (por fecha, precio, servicio)
3. **Implementar cache inteligente** para mejor rendimiento offline
4. **Agregar métricas de uso** para optimizar consultas
5. **Implementar búsqueda global** en toda la aplicación

## Soporte y Troubleshooting

### **Problemas Comunes**
- **Citas no se cargan**: Verificar permisos de Firestore y conectividad
- **Ordenamiento lento**: Verificar índices en Firestore
- **Búsqueda no funciona**: Verificar que los campos de paciente existan

### **Logs de Debug**
- Todas las funciones incluyen logs detallados
- Revisar consola para errores específicos
- Usar `print` statements para debugging

### **Optimizaciones**
- Ajustar límites de consulta según necesidades
- Implementar cache local para datos estáticos
- Usar índices compuestos en Firestore para consultas complejas

