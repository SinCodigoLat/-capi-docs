# Guía de Hosting para Documentación

Como el repositorio debe mantenerse privado, esta guía explica cómo alojar la documentación.

## 🎯 Opción Recomendada: Repositorio Público Separado

### ¿Por qué esta opción?

- ✅ **Gratis** - GitHub Pages funciona perfectamente
- ✅ **Simple** - Misma tecnología que planeamos usar
- ✅ **Seguro** - Código fuente permanece privado
- ✅ **Fácil mantenimiento** - Script de sincronización incluido

### Pasos de Implementación

#### 1. Crear Repositorio Público

1. Ve a https://github.com/SinCodigoLat
2. Crea nuevo repositorio: `capi-app-docs`
3. **IMPORTANTE:** Hazlo **público**
4. **NO** inicialices con README, .gitignore o licencia

#### 2. Sincronizar Documentación

**Opción A: Script Automatizado**

```bash
# Ejecutar script de sincronización
./scripts/sync_docs_to_public_repo.sh
```

**Opción B: Manual**

```bash
# Crear directorio temporal
cd /tmp
git clone https://github.com/SinCodigoLat/capi-app-docs.git
cd capi-app-docs

# Copiar docs desde el repo privado
cp -r /path/to/capi-app/docs/* .

# Commit y push
git add .
git commit -m "Initial documentation"
git push origin main
```

#### 3. Configurar GitHub Pages

1. Ve a: https://github.com/SinCodigoLat/capi-app-docs/settings/pages
2. En **Source**, selecciona:
   - **Branch:** `main`
   - **Folder:** `/` (raíz)
3. Haz clic en **Save**
4. Espera 1-2 minutos
5. Tu sitio estará en: `https://sincodigolat.github.io/capi-app-docs/`

#### 4. Mantener Sincronizado

Cada vez que actualices la documentación:

```bash
# Ejecutar script de sincronización
./scripts/sync_docs_to_public_repo.sh
```

O configurar GitHub Actions para sincronización automática (ver `.github/workflows/deploy-docs.yml`).

## 🔄 Alternativa: Netlify (Si prefieres un solo repo)

### Ventajas

- ✅ Todo en un solo repositorio
- ✅ Deploy automático en cada push
- ✅ Funciona con repositorios privados
- ✅ Custom domain fácil

### Pasos

1. **Crear cuenta en Netlify:**
   - Ve a https://www.netlify.com
   - Sign up con GitHub

2. **Conectar Repositorio:**
   - New site from Git
   - Selecciona `SinCodigoLat/capi-app`
   - Autoriza acceso al repo privado

3. **Configurar Build:**
   - **Base directory:** `docs`
   - **Build command:** `bundle exec jekyll build`
   - **Publish directory:** `docs/_site`

4. **Deploy:**
   - Netlify detectará cambios automáticamente
   - URL: `https://random-name.netlify.app`
   - Puedes configurar custom domain: `docs.doctorcapi.com`

5. **Configurar Variables (si es necesario):**
   - Site settings → Environment variables
   - Agregar `JEKYLL_ENV = production`

## 🔄 Alternativa: Vercel

Similar a Netlify, excelente para sitios estáticos.

### Pasos

1. **Crear cuenta:** https://vercel.com
2. **Import Git Repository:** Selecciona `SinCodigoLat/capi-app`
3. **Configurar:**
   - Framework: Other
   - Root Directory: `docs`
   - Build Command: `bundle install && bundle exec jekyll build`
   - Output Directory: `_site`
4. **Deploy:** Automático en cada push

## 📊 Comparación

| Característica | Repo Separado | Netlify | Vercel |
|----------------|---------------|---------|--------|
| **Costo** | Gratis | Gratis | Gratis |
| **Repo Privado** | ✅ Código privado | ✅ Sí | ✅ Sí |
| **Setup** | ⭐ Fácil | ⭐⭐ Media | ⭐⭐ Media |
| **Deploy Auto** | Con script/GitHub Actions | ✅ Sí | ✅ Sí |
| **Custom Domain** | ✅ Sí | ✅ Sí | ✅ Sí |
| **HTTPS** | ✅ Sí | ✅ Sí | ✅ Sí |

## 🎯 Recomendación Final

**Para máxima simplicidad:** Repositorio público separado (`capi-app-docs`)

**Para integración completa:** Netlify o Vercel

## 📝 Checklist de Implementación

### Si eliges Repositorio Separado:

- [ ] Crear `SinCodigoLat/capi-app-docs` (público)
- [ ] Ejecutar `./scripts/sync_docs_to_public_repo.sh`
- [ ] Configurar GitHub Pages en el repo público
- [ ] Verificar que el sitio funciona
- [ ] Actualizar enlaces en README principal

### Si eliges Netlify:

- [ ] Crear cuenta en Netlify
- [ ] Conectar repositorio privado
- [ ] Configurar build settings
- [ ] Primer deploy
- [ ] Configurar custom domain (opcional)

### Si eliges Vercel:

- [ ] Crear cuenta en Vercel
- [ ] Importar repositorio
- [ ] Configurar build
- [ ] Deploy
- [ ] Configurar custom domain (opcional)

---

**¿Necesitas ayuda con alguna opción específica?** Consulta los archivos de configuración creados:
- `netlify.toml` - Para Netlify
- `vercel.json` - Para Vercel
- `.github/workflows/deploy-docs.yml` - Para GitHub Actions

