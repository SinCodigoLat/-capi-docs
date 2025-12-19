#!/bin/bash

# Script para sincronizar el manual de usuario del repo privado al público
# Ejecutar desde el repositorio privado después de actualizar manual-usuario/

set -e

REPO_ACTUAL=$(pwd)
REPO_PUBLICO="../capi-app-docs-public"

echo "🔄 Sincronizando manual de usuario al repositorio público..."

# Verificar que estamos en el directorio correcto
if [ ! -f "_config.yml" ] || [ ! -d "manual-usuario" ]; then
    echo "❌ Error: Debes ejecutar este script desde el directorio de documentación privada"
    exit 1
fi

# Verificar que el repo público existe
if [ ! -d "$REPO_PUBLICO" ]; then
    echo "❌ Error: El repositorio público no existe en $REPO_PUBLICO"
    echo "   Primero ejecuta scripts/separar_repositorios.sh"
    exit 1
fi

# Copiar manual-usuario al repo público
echo "📋 Copiando manual-usuario..."
rm -rf "$REPO_PUBLICO/manual-usuario"
cp -r "$REPO_ACTUAL/manual-usuario" "$REPO_PUBLICO/"

# Copiar assets si existen
if [ -d "$REPO_ACTUAL/assets" ]; then
    cp -r "$REPO_ACTUAL/assets" "$REPO_PUBLICO/" 2>/dev/null || true
fi

# Ir al repo público y hacer commit
cd "$REPO_PUBLICO"
git add manual-usuario/ assets/ 2>/dev/null || true
git commit -m "Actualizar manual de usuario desde repo privado" || echo "⚠️  No hay cambios para commitear"

echo "✅ Sincronización completada"
echo ""
echo "📝 Para publicar los cambios:"
echo "   cd $REPO_PUBLICO"
echo "   git push origin main"
echo ""

