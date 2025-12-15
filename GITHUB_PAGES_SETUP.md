# Configuración de GitHub Pages

## Pasos para Habilitar GitHub Pages

1. Ve a tu repositorio en GitHub: `https://github.com/SinCodigoLat/capi-app`

2. Ve a **Settings** → **Pages**

3. En la sección **Source**, selecciona:
   - **Branch:** `main` (o la rama principal)
   - **Folder:** `/docs`

4. Haz clic en **Save**

5. GitHub comenzará a construir el sitio. Esto puede tomar unos minutos.

6. Una vez completado, tu sitio estará disponible en:
   `https://sincodigolat.github.io/capi-app/`

## Verificación

Después de configurar:

1. Espera 1-2 minutos para que GitHub construya el sitio
2. Visita la URL del sitio
3. Verifica que la navegación funciona
4. Verifica que los enlaces internos funcionan

## Troubleshooting

### El sitio no se muestra

- Verifica que el branch y folder están correctos
- Verifica que `_config.yml` existe en `/docs`
- Revisa los logs de GitHub Actions (si están habilitados)

### Los enlaces no funcionan

- Verifica que los archivos `.md` tienen el front matter correcto
- Verifica que los enlaces usan rutas relativas
- Verifica que la estructura de carpetas es correcta

### El tema no se aplica

- Verifica que `theme: just-the-docs` está en `_config.yml`
- Espera unos minutos para que GitHub actualice el tema
- Limpia la caché del navegador

## Actualización del Sitio

Cada vez que hagas push a la rama `main` en la carpeta `/docs`, GitHub Pages se actualizará automáticamente.

---

**Nota:** Esta configuración debe hacerse manualmente en GitHub. No se puede automatizar desde aquí.

