#!/bin/bash

# Script para separar la documentación en dos repositorios
# Repositorio Público: Solo manual-usuario
# Repositorio Privado: Todo el contenido

set -e

REPO_ACTUAL=$(pwd)
REPO_PUBLICO="../capi-app-docs-public"
REPO_PRIVADO="../capi-app-docs-private"

echo "🚀 Separando documentación en dos repositorios..."
echo ""

# Verificar que estamos en el directorio correcto
if [ ! -f "_config.yml" ]; then
    echo "❌ Error: Debes ejecutar este script desde el directorio de documentación"
    exit 1
fi

# Crear repositorio público
echo "📦 Preparando repositorio público..."
if [ -d "$REPO_PUBLICO" ]; then
    echo "⚠️  El directorio $REPO_PUBLICO ya existe. ¿Deseas continuar? (s/n)"
    read -r respuesta
    if [ "$respuesta" != "s" ]; then
        echo "❌ Operación cancelada"
        exit 1
    fi
    rm -rf "$REPO_PUBLICO"
fi

mkdir -p "$REPO_PUBLICO"
cd "$REPO_PUBLICO"
git init

# Copiar solo manual-usuario y archivos necesarios
echo "📋 Copiando archivos públicos..."
cp -r "$REPO_ACTUAL/manual-usuario" .
cp "$REPO_ACTUAL/Gemfile" .
cp "$REPO_ACTUAL/.gitignore" .
cp -r "$REPO_ACTUAL/assets" . 2>/dev/null || true

# Copiar configuraciones públicas
cp "$REPO_ACTUAL/_config.public.yml" _config.yml
cp "$REPO_ACTUAL/index.public.md" index.md
cp "$REPO_ACTUAL/README_PUBLICO.md" README.md

# Commit inicial
git add .
git commit -m "Initial commit: Manual de Usuario público" || echo "⚠️  No se pudo hacer commit (puede que no haya cambios)"

echo "✅ Repositorio público preparado en: $REPO_PUBLICO"
echo ""

# Crear repositorio privado
echo "📦 Preparando repositorio privado..."
if [ -d "$REPO_PRIVADO" ]; then
    echo "⚠️  El directorio $REPO_PRIVADO ya existe. ¿Deseas continuar? (s/n)"
    read -r respuesta
    if [ "$respuesta" != "s" ]; then
        echo "❌ Operación cancelada"
        exit 1
    fi
    rm -rf "$REPO_PRIVADO"
fi

mkdir -p "$REPO_PRIVADO"
cd "$REPO_PRIVADO"
git init

# Copiar todo el contenido
echo "📋 Copiando archivos privados..."
cp -r "$REPO_ACTUAL"/* .
cp "$REPO_ACTUAL"/.gitignore . 2>/dev/null || true
cp "$REPO_ACTUAL"/.gitignore . 2>/dev/null || true

# Excluir archivos de configuración pública
rm -f _config.public.yml index.public.md README_PUBLICO.md

# Copiar README privado
cp "$REPO_ACTUAL/README_PRIVADO.md" README.md

git add .
git commit -m "Initial commit: Documentación completa privada" || echo "⚠️  No se pudo hacer commit (puede que no haya cambios)"

echo "✅ Repositorio privado preparado en: $REPO_PRIVADO"
echo ""

echo "🎉 ¡Separación completada!"
echo ""
echo "📝 Próximos pasos:"
echo ""
echo "1. Crear repositorios en GitHub:"
echo "   - Público: https://github.com/new (nombre: capi-app-docs-public, PUBLIC)"
echo "   - Privado: https://github.com/new (nombre: capi-app-docs-private, PRIVATE)"
echo ""
echo "2. Agregar remotes y hacer push:"
echo "   cd $REPO_PUBLICO"
echo "   git remote add origin https://github.com/SinCodigoLat/capi-app-docs-public.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "   cd $REPO_PRIVADO"
echo "   git remote add origin https://github.com/SinCodigoLat/capi-app-docs-private.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "3. Configurar GitHub Pages:"
echo "   - Público: Settings → Pages → Branch: main, Folder: /"
echo "   - Privado: Settings → Pages → Branch: main, Folder: /"
echo ""

