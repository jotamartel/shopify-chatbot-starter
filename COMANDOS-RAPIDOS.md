# ⚡ COMANDOS RÁPIDOS - Shopify Chatbot

**Para:** Crear proyectos nuevos desde cero  
**Versión:** 1.0

---

## 🚀 OPCIÓN 1: SETUP AUTOMÁTICO (RECOMENDADO)

### Un solo comando para crear todo:

```bash
./setup-nuevo-proyecto.sh mi-nuevo-chatbot
```

✅ **Esto crea automáticamente:**
- Estructura de directorios
- Archivos base del widget
- Backend API
- Configuración Vercel
- Archivos Shopify
- Documentación
- Git repo inicializado

---

## 🛠️ OPCIÓN 2: SETUP MANUAL

### Comandos en orden cronológico (copy-paste):

```bash
# 1. Crear y setup básico
mkdir mi-chatbot && cd mi-chatbot
git init
npm init -y

# 2. Estructura
mkdir -p widget api lib docs shopify-theme

# 3. Instalar dependencias
npm install groq-sdk dotenv

# 4. Crear .gitignore
cat > .gitignore << 'EOF'
node_modules/
.env*
.DS_Store
.vercel/
*.log
EOF

# 5. Crear vercel.json
cat > vercel.json << 'EOF'
{
  "version": 2,
  "builds": [{"src": "api/**/*.js", "use": "@vercel/node"}]
}
EOF

# 6. Crear archivos del widget
# (Ver STARTER-KIT-CHATBOT-SHOPIFY.md para código completo)

# 7. Crear API backend
# (Ver STARTER-KIT-CHATBOT-SHOPIFY.md para código completo)

# 8. Configurar .env.local
cat > .env.local << 'EOF'
GROQ_API_KEY=tu_key_aqui
SHOPIFY_STORE_DOMAIN=tu-tienda.myshopify.com
SHOPIFY_STOREFRONT_TOKEN=tu_token_aqui
STORE_NAME=Tu Tienda
EOF

# 9. Commit inicial
git add .
git commit -m "🎉 Setup inicial"
```

---

## 🌐 DEPLOYMENT

### Vercel (Backend):

```bash
# Login
vercel login

# Deploy
vercel

# Configurar variables
vercel env add GROQ_API_KEY
vercel env add SHOPIFY_STORE_DOMAIN
vercel env add SHOPIFY_STOREFRONT_TOKEN
vercel env add STORE_NAME

# Deploy a producción
vercel --prod

# Ver logs
vercel logs
```

### Shopify (Frontend):

```bash
# Login
shopify login --store tu-tienda

# Pull tema
shopify theme pull --store=tu-tienda --theme=THEME_ID

# Copiar archivos
cp widget/chatbot-widget.js your-theme/assets/
cp widget/chatbot-widget.css your-theme/assets/
cp shopify-theme/chatbot-widget.liquid your-theme/snippets/

# Push a Shopify
shopify theme push --store=tu-tienda --theme=THEME_ID --allow-live \
  --only assets/chatbot-widget.js \
  --only assets/chatbot-widget.css \
  --only snippets/chatbot-widget.liquid
```

---

## 📝 WORKFLOW DE DESARROLLO

### Testing Local:

```bash
# Iniciar servidor local
vercel dev

# En otro terminal: watch de archivos
# (si usas algún bundler)
```

### Deploy Rápido:

```bash
# 1. Hacer cambios en widget/
vim widget/chatbot-widget.js

# 2. Commit
git add .
git commit -m "✨ Nueva feature"

# 3. Deploy backend
vercel --prod

# 4. Deploy frontend
cp widget/* shopify-theme-temp/assets/
shopify theme push --store=tu-tienda --allow-live \
  --only assets/chatbot-widget.js
```

---

## 🔧 MANTENIMIENTO

### Actualizar dependencias:

```bash
npm update
npm audit fix
```

### Ver logs:

```bash
# Vercel
vercel logs shopify-chatbot --follow

# Shopify (en navegador)
# F12 → Console
```

### Backup:

```bash
# Crear backup
git tag -a "backup-$(date +%Y%m%d)" -m "Backup automático"
git push origin --tags

# O manual
mkdir backup-$(date +%Y%m%d)
cp -r widget api lib backup-$(date +%Y%m%d)/
```

---

## 🎯 COMANDOS MÁS USADOS

### Development:

```bash
vercel dev                    # Test local
vercel --prod                 # Deploy producción
shopify theme dev             # Dev theme local
```

### Git:

```bash
git status                    # Ver cambios
git add .                     # Agregar todo
git commit -m "mensaje"       # Commit
git push                      # Push a GitHub
git log --oneline -10         # Ver historial
```

### NPM:

```bash
npm install                   # Instalar deps
npm list                      # Ver instaladas
npm outdated                  # Ver updates
npm update                    # Actualizar
```

---

## 📚 OBTENER API KEYS

### Groq (IA):

```
1. Ir a: https://console.groq.com
2. Crear cuenta (gratis)
3. Dashboard → API Keys
4. Create API Key
5. Copiar y guardar
```

### Shopify Storefront Token:

```
1. Admin Shopify
2. Apps → Develop apps
3. Create an app
4. Configure → Storefront API
5. Select scopes:
   - unauthenticated_read_product_listings
   - unauthenticated_read_product_inventory
6. Install app
7. Storefront API access token → Copiar
```

---

## 🐛 TROUBLESHOOTING RÁPIDO

### "No aparece el chatbot":

```bash
# 1. Limpiar caché
Cmd+Shift+R (Mac)
Ctrl+Shift+R (Windows)

# 2. Verificar en Shopify
shopify theme pull --store=tu-tienda
ls -lh assets/chatbot-widget.js

# 3. Ver consola
F12 → Console (buscar errores)
```

### "API no responde":

```bash
# 1. Ver logs
vercel logs --follow

# 2. Verificar variables
vercel env ls

# 3. Re-deploy
vercel --prod --force
```

### "Cambios no se reflejan":

```bash
# 1. Verificar que copiaste archivos
ls -lh shopify-theme-temp/assets/

# 2. Re-push con force
shopify theme push --store=tu-tienda --allow-live

# 3. Usar modo incógnito
Cmd+Shift+N (Chrome)
```

---

## 🎨 PERSONALIZACIÓN RÁPIDA

### Cambiar colores:

```css
/* En widget/chatbot-widget.css */
:root {
  --chatbot-primary: #TU_COLOR;
  --chatbot-success: #TU_COLOR;
}
```

### Cambiar mensajes:

```javascript
// En widget/chatbot-widget.js
// Buscar y reemplazar textos
this.addMessage('¡Tu mensaje aquí!', 'bot');
```

### Cambiar altura:

```css
/* En widget/chatbot-widget.css */
.chatbot-window {
  height: 700px; /* Ajustar */
}
```

---

## 📦 CREAR NUEVA INSTANCIA

### Para nueva tienda (desde proyecto existente):

```bash
# 1. Clonar proyecto base
git clone https://github.com/jotamartel/shopify-chatbot-backend.git nueva-tienda-chatbot
cd nueva-tienda-chatbot

# 2. Limpiar git
rm -rf .git
git init

# 3. Actualizar .env.local
nano .env.local
# (cambiar SHOPIFY_STORE_DOMAIN y tokens)

# 4. Deploy a Vercel (nuevo proyecto)
vercel

# 5. Actualizar snippet de Shopify
nano shopify-theme/chatbot-widget.liquid
# (cambiar URL de Vercel)

# 6. Deploy a nueva tienda
shopify login --store nueva-tienda
shopify theme push --store=nueva-tienda
```

---

## ✅ CHECKLIST PRE-DEPLOY

Antes de deployar a producción:

- [ ] Variables de entorno configuradas
- [ ] API keys válidas
- [ ] Código probado localmente con `vercel dev`
- [ ] Sin errores en consola (F12)
- [ ] Git commit realizado
- [ ] Backup creado (tag o carpeta)
- [ ] URL de Vercel actualizada en Shopify
- [ ] Cache limpiado después del deploy

---

## 🔗 ENLACES ÚTILES

- **Documentación Groq:** https://console.groq.com/docs
- **Shopify Storefront API:** https://shopify.dev/docs/api/storefront
- **Vercel Docs:** https://vercel.com/docs
- **Shopify CLI:** https://shopify.dev/docs/themes/tools/cli

---

## 📞 REFERENCIAS

- **Proyecto Base:** https://github.com/jotamartel/shopify-chatbot-backend
- **Starter Kit:** `STARTER-KIT-CHATBOT-SHOPIFY.md`
- **Context Skill:** `0-SKILLS-Julian.md`
- **Setup Script:** `./setup-nuevo-proyecto.sh`

---

**Última Actualización:** 1 de Noviembre, 2025  
**Mantenido por:** Julian Martel (@jotamartel)

