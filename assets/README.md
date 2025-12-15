# Assets para Documentación

Esta carpeta contiene recursos estáticos para la documentación.

## Estructura

```
assets/
├── screenshots/          # Capturas de pantalla
│   ├── doctor/         # Capturas de flujos de doctor
│   ├── paciente/       # Capturas de flujos de paciente
│   └── asistente/      # Capturas de flujos de asistente
└── diagrams/           # Diagramas adicionales (opcional)
```

## Capturas de Pantalla

### Organización

Las capturas deben organizarse por:
- **Rol:** doctor/, paciente/, asistente/
- **Funcionalidad:** gestion-pacientes/, crear-consultas/, etc.

### Convenciones de Nombres

- Usar nombres descriptivos: `crear-paciente-paso1.png`
- Incluir número de paso si aplica: `agendar-cita-paso2.png`
- Usar guiones en lugar de espacios

### Tamaños Recomendados

- **Móvil:** 375x812 (iPhone) o 360x640 (Android)
- **Tablet:** 768x1024
- **Desktop:** 1920x1080

### Optimización

- Comprimir imágenes antes de subir
- Usar formato PNG para capturas con texto
- Usar formato JPG para fotos si aplica
- Mantener tamaño de archivo razonable (< 500KB por imagen)

## Uso en Documentación

Para incluir capturas en la documentación:

```markdown
![Descripción de la imagen](./assets/screenshots/doctor/crear-paciente.png)
```

---

**Nota:** Esta carpeta está preparada para futuras capturas de pantalla. Por ahora está vacía.

