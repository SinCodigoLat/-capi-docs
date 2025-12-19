# 📋 Instrucciones para Separar Documentación en Dos Repositorios

Esta guía te ayudará a separar la documentación en un repositorio público (solo manual de usuario) y un repositorio privado (documentación completa).

## 🎯 Objetivo

- **Repositorio Público**: Solo `manual-usuario/` → Accesible públicamente
- **Repositorio Privado**: Todo el contenido → Solo para la empresa

## 📦 Paso 1: Crear Repositorios en GitHub

### Repositorio Público

1. Ve a: https://github.com/new
2. **Owner**: SinCodigoLat
3. **Repository name**: `capi-app-docs-public`
4. **Description**: "Manual de Usuario público de CAPI App"
5. **Visibilidad**: ✅ **PUBLIC**
6. **NO** marques README, .gitignore o licencia
7. Click "Create repository"

### Repositorio Privado

1. Ve a: https://github.com/new
2. **Owner**: SinCodigoLat
3. **Repository name**: `capi-app-docs-private`
4. **Description**: "Documentación completa privada de CAPI App"
5. **Visibilidad**: 🔒 **PRIVATE**
6. **NO** marques README, .gitignore o licencia
7. Click "Create repository"

## 🚀 Paso 2: Ejecutar Script de Separación

Desde el directorio de documentación actual:

```bash
cd /Users/jorgevaldez/Desktop/Development/FlutterFlow/CapiApp/documentacion-capi
./scripts/separar_repositorios.sh
```

Este script creará dos directorios:
- `../capi-app-docs-public/` - Solo manual-usuario
- `../capi-app-docs-private/` - Todo el contenido

## 📤 Paso 3: Subir Repositorio Público

```bash
cd ../capi-app-docs-public
git remote add origin https://github.com/SinCodigoLat/capi-app-docs-public.git
git branch -M main
git push -u origin main
```

## 📤 Paso 4: Subir Repositorio Privado

```bash
cd ../capi-app-docs-private
git remote add origin https://github.com/SinCodigoLat/capi-app-docs-private.git
git branch -M main
git push -u origin main
```

## ⚙️ Paso 5: Configurar Hosting

### Repositorio Público (GitHub Pages)

1. Ve a: https://github.com/SinCodigoLat/capi-app-docs-public/settings/pages
2. **Source**: Branch `main`
3. **Folder**: `/` (raíz)
4. **Custom domain**: `manual.doctorcapi.com`
5. Click "Save"
6. Espera 1-2 minutos
7. **URL Final**: http://manual.doctorcapi.com

### Repositorio Privado (Firebase Hosting)

1. Configurar Firebase Hosting (ver `FIREBASE_HOSTING_SETUP.md`)
2. Crear sitio: `firebase hosting:sites:create docs-private`
3. Configurar dominio personalizado en Firebase Console
4. **URL Final**: https://docs.doctorcapi.com
5. **URL Alternativa**: https://docs-private.web.app

## 🔄 Paso 6: Sincronización Futura

Cuando actualices el `manual-usuario/` en el repositorio privado, sincronízalo al público:

```bash
# Desde el repositorio privado
cd /path/to/capi-app-docs-private
./scripts/sync_manual_usuario.sh

# Luego hacer push al repo público
cd ../capi-app-docs-public
git push origin main
```

## ✅ Verificación

### Repositorio Público

- [x] El sitio carga en: http://manual.doctorcapi.com
- [x] Solo muestra el Manual de Usuario
- [x] No hay enlaces al Manual Técnico
- [x] La navegación funciona correctamente
- [x] Dominio personalizado configurado

### Repositorio Privado

- [x] El sitio carga en: https://docs.doctorcapi.com
- [x] Muestra todo el contenido (Manual Técnico, Referencias, Manual de Usuario)
- [x] Hosting en Firebase Hosting
- [x] La navegación funciona correctamente
- [x] Dominio personalizado configurado
- [x] Deploy automático con GitHub Actions

## 📝 Archivos Creados

### Para Repositorio Público

- `_config.public.yml` → Copiar como `_config.yml`
- `index.public.md` → Copiar como `index.md`
- `README_PUBLICO.md` → Copiar como `README.md`
- `manual-usuario/` → Copiar completo
- `Gemfile` → Copiar
- `.gitignore` → Copiar
- `assets/` → Copiar (si existe)

### Para Repositorio Privado

- `_config.yml` → Ya actualizado con baseurl privado
- `index.md` → Ya actualizado
- `README_PRIVADO.md` → Copiar como `README.md`
- Todo el contenido actual

## 🆘 Troubleshooting

### El script falla

- Verifica que tienes permisos de escritura en el directorio padre
- Verifica que no existen los directorios `capi-app-docs-public` o `capi-app-docs-private`
- Ejecuta el script desde el directorio de documentación

### GitHub Pages no funciona

- Verifica que el branch es `main`
- Verifica que el folder es `/` (raíz)
- Espera 1-2 minutos después de hacer push
- Revisa los logs en Settings → Pages → Build logs

### El sitio privado es accesible públicamente

- Verifica que el repositorio está marcado como PRIVATE
- Verifica que solo miembros autorizados tienen acceso
- GitHub Pages en repos privados requiere autenticación automáticamente

## 📞 Soporte

Si tienes problemas, consulta:
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Jekyll Documentation](https://jekyllrb.com/docs/)

## 🎉 Estado Final

**✅ COMPLETADO - Diciembre 2024**

### Sitios Publicados

- **Manual de Usuario (Público):** http://manual.doctorcapi.com
- **Documentación Completa (Privado):** https://docs.doctorcapi.com

### Repositorios

- **Público:** https://github.com/SinCodigoLat/capi-app-docs-public
- **Privado:** https://github.com/SinCodigoLat/capi-app-docs-private

---

**Última actualización:** Diciembre 2024

