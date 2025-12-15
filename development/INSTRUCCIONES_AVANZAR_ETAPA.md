# Instrucciones para Avanzar a la Siguiente Etapa

## Problema
Estás en la página de completar perfil profesional, pero ya completaste tus datos de usuario.

## Solución
Avanzar a la siguiente etapa en el flujo de incorporación.

## Flujo de Etapas
1. `inicio_01` → Página de suscripción
2. `adquirioSuscripcion_02` → Completar perfil profesional ← **ESTÁS AQUÍ**
3. `completoPerfil_03` → Configuración onboarding ← **SIGUIENTE**
4. `configuroNegocio_04` → Dashboard de pacientes ← **OBJETIVO**

## Pasos para Avanzar

### 1. Ir a Firebase Console
- Ve a [Firebase Console](https://console.firebase.google.com/project/capideveloper-6078c/firestore)
- Navega a Firestore Database

### 2. Actualizar el Usuario
- Ve a la colección `users`
- Busca el documento con ID: `4oTyzcBu00WD7x0wB8IffBRY6ym2`
- Haz clic en el documento para editarlo

### 3. Cambiar la Etapa
Cambia el campo `etapaIncorporacion` de `adquirioSuscripcion_02` a `completoPerfil_03`

## Resultado Esperado
Después de este cambio:
1. La validación te llevará a `ConfiguracionOnboardingWidget`
2. Podrás completar la configuración del negocio
3. Finalmente llegarás al dashboard de pacientes

## Alternativa: Ir Directamente al Dashboard
Si quieres saltar directamente al dashboard, cambia `etapaIncorporacion` a `configuroNegocio_04`

## Verificación
- Recarga la aplicación
- Deberías ir a la página de configuración de onboarding o directamente al dashboard

