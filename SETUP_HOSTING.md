# Setup Rápido: Hosting de Documentación

## 🚀 Opción Más Rápida: Repositorio Público Separado

### Paso 1: Crear Repositorio Público

1. Ve a: https://github.com/organizations/SinCodigoLat/repositories/new
2. Nombre: `capi-app-docs`
3. Descripción: "Documentación pública de CAPI App"
4. **Visibilidad: PUBLIC** ⚠️
5. **NO** marques README, .gitignore o licencia
6. Click "Create repository"

### Paso 2: Sincronizar Documentación

```bash
# Desde el repositorio privado, ejecutar:
./scripts/sync_docs_to_public_repo.sh
```

Si el script falla porque el repo no existe aún:

```bash
# Crear manualmente
cd /tmp
mkdir capi-app-docs
cd capi-app-docs
git init
git remote add origin https://github.com/SinCodigoLat/capi-app-docs.git

# Copiar docs
cp -r /path/to/capi-app/docs/* .

# Commit y push
git add .
git commit -m "Initial documentation"
git branch -M main
git push -u origin main
```

### Paso 3: Configurar GitHub Pages

1. Ve a: https://github.com/SinCodigoLat/capi-app-docs/settings/pages
2. Source: Branch `main`, Folder `/` (raíz)
3. Save
4. Espera 1-2 minutos
5. Visita: https://sincodigolat.github.io/capi-app-docs/

### Paso 4: Verificar

- [ ] El sitio carga correctamente
- [ ] La navegación funciona
- [ ] Los enlaces internos funcionan
- [ ] La búsqueda funciona

## 🔄 Mantener Sincronizado

Cada vez que actualices docs en el repo privado:

```bash
./scripts/sync_docs_to_public_repo.sh
```

O configura GitHub Actions para sincronización automática.

---

**¿Problemas?** Consulta `ALTERNATIVAS_HOSTING.md` para otras opciones.

