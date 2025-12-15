# 🚀 Scripts de Desarrollo - Capi App

## Scripts Disponibles

### 1. `run_web.sh` - Arranque Completo
```bash
./run_web.sh
```
**¿Cuándo usar?**
- Primera vez que ejecutas el proyecto
- Después de cambios en `pubspec.yaml`
- Cuando hay problemas de caché
- Para un arranque limpio y garantizado

**¿Qué hace?**
- `flutter clean` - Limpia caché y archivos temporales
- `flutter pub get` - Instala/actualiza dependencias
- `flutter run` - Ejecuta en Chrome con renderer HTML

### 2. `run_web_dev.sh` - Desarrollo Rápido
```bash
./run_web_dev.sh
```
**¿Cuándo usar?**
- Desarrollo diario normal
- Cuando ya tienes el proyecto configurado
- Para arranques rápidos durante desarrollo

**¿Qué hace?**
- `flutter run` - Ejecuta directamente en Chrome
- Sin limpiar caché (más rápido)

## 🌐 Configuración Web

### Renderer HTML
Los scripts usan `--dart-define=FLUTTER_WEB_RENDERER=html` para:
- Mejor compatibilidad con navegadores
- Resolver problemas de renderizado
- Optimizar para desarrollo web

### Puerto
- **Puerto por defecto:** 3000
- **URL:** http://localhost:3000

## 🔧 Solución de Problemas

### Si la pantalla aparece en blanco:
1. Usa `./run_web.sh` (arranque completo)
2. Verifica la consola del navegador (F12)
3. Revisa que Firebase esté inicializado correctamente

### Si hay errores de dependencias:
```bash
flutter clean
flutter pub get
./run_web.sh
```

### Si el puerto 3000 está ocupado:
```bash
# Matar procesos en puerto 3000
lsof -ti:3000 | xargs kill -9

# O usar otro puerto
flutter run -d chrome --web-port=3001
```

## 📝 Notas de Desarrollo

- Los scripts están configurados para Chrome
- El renderer HTML es más estable para web
- Los flags de debug están en `lib/main.dart`
- Firebase se inicializa automáticamente
