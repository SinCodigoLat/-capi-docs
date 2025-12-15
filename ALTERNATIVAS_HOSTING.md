# Alternativas de Hosting para Documentación

Como el repositorio debe mantenerse privado, aquí están las mejores alternativas para alojar la documentación.

## 🎯 Opciones Recomendadas

### Opción 1: Repositorio Público Separado (RECOMENDADA)

Crear un repositorio público **solo para la documentación**.

**Ventajas:**
- ✅ Gratis
- ✅ GitHub Pages funciona perfectamente
- ✅ Código fuente permanece privado
- ✅ Fácil de mantener sincronizado

**Implementación:**

1. **Crear nuevo repositorio público:**
   ```
   https://github.com/SinCodigoLat/capi-app-docs
   ```

2. **Copiar solo la carpeta docs:**
   ```bash
   # Crear nuevo repo para docs
   cd /tmp
   git clone https://github.com/SinCodigoLat/capi-app.git temp-repo
   cd temp-repo
   
   # Crear nuevo repo solo con docs
   git subtree push --prefix=docs origin docs-only
   
   # O simplemente copiar docs a nuevo repo
   mkdir capi-app-docs
   cp -r docs/* capi-app-docs/
   cd capi-app-docs
   git init
   git add .
   git commit -m "Initial docs"
   git remote add origin https://github.com/SinCodigoLat/capi-app-docs.git
   git push -u origin main
   ```

3. **Configurar GitHub Pages en el repo público:**
   - Settings → Pages
   - Source: Branch `main`, Folder `/` (raíz)
   - URL: `https://sincodigolat.github.io/capi-app-docs/`

4. **Mantener sincronizado:**
   ```bash
   # Script para actualizar docs cuando cambien
   # En el repo privado, ejecutar:
   git subtree push --prefix=docs origin docs-only
   ```

### Opción 2: Netlify (GRATIS)

Netlify puede desplegar desde repositorios privados.

**Ventajas:**
- ✅ Gratis para proyectos open source
- ✅ Funciona con repositorios privados
- ✅ Deploy automático en cada push
- ✅ HTTPS incluido
- ✅ Custom domain

**Implementación:**

1. **Crear cuenta en Netlify:**
   - Ve a https://www.netlify.com
   - Conecta con GitHub

2. **Configurar deploy:**
   - New site from Git
   - Selecciona repositorio privado `SinCodigoLat/capi-app`
   - Build settings:
     - **Base directory:** `docs`
     - **Build command:** (vacío, Jekyll se construye automáticamente)
     - **Publish directory:** `docs/_site` (o dejar vacío para Jekyll)

3. **Configurar Jekyll:**
   - Netlify detecta Jekyll automáticamente
   - O crear `netlify.toml`:
   ```toml
   [build]
     base = "docs"
     command = "bundle exec jekyll build"
     publish = "docs/_site"
   
   [build.environment]
     JEKYLL_ENV = "production"
   ```

4. **URL resultante:**
   - `https://random-name.netlify.app`
   - O configurar custom domain: `docs.doctorcapi.com`

### Opción 3: Vercel (GRATIS)

Similar a Netlify, funciona con repos privados.

**Ventajas:**
- ✅ Gratis
- ✅ Deploy automático
- ✅ Excelente para sitios estáticos
- ✅ HTTPS y custom domain

**Implementación:**

1. **Crear cuenta en Vercel:**
   - Ve a https://vercel.com
   - Conecta con GitHub

2. **Configurar proyecto:**
   - Import Git Repository
   - Selecciona `SinCodigoLat/capi-app`
   - Framework Preset: **Other**
   - Root Directory: `docs`
   - Build Command: `bundle exec jekyll build`
   - Output Directory: `_site`

3. **Crear `vercel.json`:**
   ```json
   {
     "buildCommand": "cd docs && bundle exec jekyll build",
     "outputDirectory": "docs/_site",
     "framework": null
   }
   ```

### Opción 4: Firebase Hosting (GRATIS)

Ya tienes Firebase configurado, puedes usar Hosting.

**Ventajas:**
- ✅ Ya tienes cuenta Firebase
- ✅ Gratis (generoso free tier)
- ✅ Integrado con tu proyecto
- ✅ Custom domain fácil

**Implementación:**

1. **Configurar Firebase Hosting:**
   ```bash
   firebase init hosting
   ```
   - Selecciona proyecto existente
   - Public directory: `docs/_site`
   - Configure as single-page app: No
   - Set up automatic builds: No

2. **Build Jekyll localmente:**
   ```bash
   cd docs
   bundle install
   bundle exec jekyll build
   ```

3. **Deploy:**
   ```bash
   firebase deploy --only hosting
   ```

4. **Automatizar con GitHub Actions:**
   - Crear workflow que construya y despliegue automáticamente

### Opción 5: GitLab Pages (GRATIS)

GitLab Pages funciona con repositorios privados.

**Ventajas:**
- ✅ Gratis con repos privados
- ✅ Similar a GitHub Pages
- ✅ CI/CD integrado

**Implementación:**

1. **Migrar o crear mirror en GitLab:**
   - Crear cuenta en GitLab
   - Importar repositorio desde GitHub

2. **Configurar `.gitlab-ci.yml`:**
   ```yaml
   image: ruby:3.0
   
   pages:
     stage: deploy
     script:
       - cd docs
       - bundle install
       - bundle exec jekyll build -d public
     artifacts:
       paths:
         - public
     only:
       - main
   ```

## 📊 Comparación Rápida

| Opción | Costo | Repo Privado | Dificultad | Recomendación |
|--------|-------|--------------|------------|---------------|
| **Repo Público Separado** | Gratis | ✅ Código privado | ⭐ Fácil | ⭐⭐⭐⭐⭐ |
| **Netlify** | Gratis | ✅ Sí | ⭐⭐ Media | ⭐⭐⭐⭐ |
| **Vercel** | Gratis | ✅ Sí | ⭐⭐ Media | ⭐⭐⭐⭐ |
| **Firebase Hosting** | Gratis | ✅ Sí | ⭐⭐⭐ Media-Alta | ⭐⭐⭐ |
| **GitLab Pages** | Gratis | ✅ Sí | ⭐⭐⭐ Media-Alta | ⭐⭐⭐ |

## 🎯 Recomendación Final

### Para Simplicidad: Repositorio Público Separado

**Pasos:**

1. Crear `SinCodigoLat/capi-app-docs` (público)
2. Copiar solo `docs/` a ese repo
3. Configurar GitHub Pages ahí
4. Mantener sincronizado con script o GitHub Actions

**Ventajas:**
- Más simple de mantener
- GitHub Pages nativo
- Separación clara código/docs
- Gratis

### Para Integración: Netlify o Vercel

Si prefieres mantener todo en un solo repositorio:

- **Netlify:** Mejor para Jekyll, más fácil de configurar
- **Vercel:** Más rápido, mejor para sitios estáticos modernos

## 🚀 Implementación Rápida: Repositorio Separado

### Script de Sincronización

Crear `scripts/sync_docs.sh`:

```bash
#!/bin/bash
# Sincroniza docs al repositorio público

DOCS_REPO="git@github.com:SinCodigoLat/capi-app-docs.git"
TEMP_DIR="/tmp/capi-docs-sync"

# Crear directorio temporal
rm -rf $TEMP_DIR
mkdir -p $TEMP_DIR

# Clonar repo de docs
git clone $DOCS_REPO $TEMP_DIR

# Copiar docs actualizados
cp -r docs/* $TEMP_DIR/

# Commit y push
cd $TEMP_DIR
git add .
git commit -m "Update documentation $(date +%Y-%m-%d)"
git push origin main

# Limpiar
rm -rf $TEMP_DIR

echo "✅ Documentación sincronizada"
```

## 📝 Próximos Pasos

1. **Decide qué opción prefieres**
2. **Si eliges repo separado:**
   - Crear `SinCodigoLat/capi-app-docs`
   - Ejecutar script de sincronización
   - Configurar GitHub Pages

3. **Si eliges Netlify/Vercel:**
   - Crear cuenta
   - Conectar repositorio
   - Configurar deploy
   - Personalizar dominio (opcional)

---

**Recomendación:** Repositorio público separado es la opción más simple y mantenible.

