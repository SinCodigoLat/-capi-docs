# 🌐 Configuración de Dominio Personalizado - manual.doctorcapi.com

Esta guía explica cómo configurar el dominio personalizado `manual.doctorcapi.com` para el manual de usuario público.

## 📋 Requisitos Previos

- Repositorio público creado en GitHub: `capi-app-docs-public`
- Acceso al DNS del dominio `doctorcapi.com`
- Acceso de administrador al repositorio en GitHub

## 🚀 Paso 1: Configurar DNS

### Opción A: Subdominio (Recomendado)

En tu proveedor de DNS (donde está configurado `doctorcapi.com`), agrega un registro CNAME:

```
Tipo: CNAME
Nombre: manual
Valor: sincodigolat.github.io
TTL: 3600 (o el valor por defecto)
```

**Ejemplo de configuración:**
- **Host/Name**: `manual`
- **Type**: `CNAME`
- **Value/Points to**: `sincodigolat.github.io`
- **TTL**: `3600` o `Auto`

### Opción B: Registro A (Alternativa)

Si CNAME no está disponible, usa registros A:

```
Tipo: A
Nombre: manual
Valor: 185.199.108.153
TTL: 3600

Tipo: A
Nombre: manual
Valor: 185.199.109.153
TTL: 3600

Tipo: A
Nombre: manual
Valor: 185.199.110.153
TTL: 3600

Tipo: A
Nombre: manual
Valor: 185.199.111.153
TTL: 3600
```

**Nota:** Los IPs de GitHub pueden cambiar. Verifica las IPs actuales en: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site#configuring-a-subdomain

## ⚙️ Paso 2: Configurar en GitHub

1. Ve a tu repositorio: https://github.com/SinCodigoLat/capi-app-docs-public
2. Ve a **Settings** → **Pages**
3. En la sección **Custom domain**, ingresa: `manual.doctorcapi.com`
4. Click **Save**
5. GitHub creará automáticamente un archivo `CNAME` en tu repositorio

## ✅ Paso 3: Verificar Configuración

### Verificar DNS

Usa estos comandos para verificar que el DNS está configurado correctamente:

```bash
# Verificar CNAME
dig manual.doctorcapi.com CNAME +short

# Debe mostrar: sincodigolat.github.io

# Verificar resolución
nslookup manual.doctorcapi.com

# Debe mostrar las IPs de GitHub Pages
```

### Verificar en GitHub

1. Ve a Settings → Pages
2. Debe mostrar: ✅ **"Your site is published at https://manual.doctorcapi.com"**
3. Debe mostrar: ✅ **"DNS check successful"**

## 🔄 Paso 4: Actualizar Repositorio Local

Si ya tienes el repositorio clonado localmente:

```bash
cd ../capi-app-docs-public

# Pull el archivo CNAME que GitHub creó
git pull origin main

# O crear manualmente si no existe
echo "manual.doctorcapi.com" > CNAME
git add CNAME
git commit -m "Agregar dominio personalizado"
git push origin main
```

## 🔒 Paso 5: Habilitar HTTPS (Automático)

GitHub Pages automáticamente:
- Proporciona certificado SSL gratuito
- Habilita HTTPS
- Redirige HTTP a HTTPS

**Nota:** Puede tomar hasta 24 horas para que el certificado SSL se active.

## ✅ Verificación Final

Después de configurar, verifica:

- [ ] El sitio carga en: `https://manual.doctorcapi.com`
- [ ] El sitio redirige HTTP a HTTPS
- [ ] El certificado SSL está activo (candado verde)
- [ ] Todos los enlaces funcionan correctamente
- [ ] La navegación funciona

## 🆘 Troubleshooting

### El dominio no carga

1. **Verifica DNS:**
   ```bash
   dig manual.doctorcapi.com
   ```
   Debe mostrar las IPs de GitHub o el CNAME correcto.

2. **Espera propagación DNS:**
   - Los cambios DNS pueden tardar hasta 48 horas
   - Usa: https://www.whatsmydns.net/ para verificar propagación

3. **Verifica en GitHub:**
   - Settings → Pages debe mostrar el dominio configurado
   - Debe mostrar "DNS check successful"

### Error de certificado SSL

- GitHub genera certificados automáticamente
- Puede tardar hasta 24 horas
- Verifica que el DNS esté correctamente configurado
- Asegúrate de que el dominio esté en el campo "Custom domain" en GitHub

### El sitio carga pero muestra 404

- Verifica que `baseurl: ""` esté en `_config.yml`
- Verifica que el archivo `CNAME` existe en la raíz
- Verifica que el contenido esté en la rama `main`
- Limpia la caché del navegador

### Redirección infinita

- Verifica que solo tengas un dominio configurado en GitHub
- No configures tanto el dominio personalizado como el subdominio de GitHub
- Verifica que `url` en `_config.yml` coincida con el dominio personalizado

## 📝 Notas Importantes

1. **Propagación DNS:** Los cambios pueden tardar entre 1-48 horas
2. **Certificado SSL:** GitHub lo genera automáticamente, puede tardar hasta 24 horas
3. **CNAME vs A:** CNAME es más fácil de mantener (recomendado)
4. **Solo un dominio:** GitHub Pages solo permite un dominio personalizado por repositorio

## 🔗 Referencias

- [GitHub Pages Custom Domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [Verificar DNS](https://www.whatsmydns.net/)
- [IPs de GitHub Pages](https://api.github.com/meta)

---

**Última actualización:** Diciembre 2024

