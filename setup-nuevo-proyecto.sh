#!/bin/bash
# 🚀 SCRIPT DE SETUP AUTOMÁTICO - Shopify Chatbot con IA
# Versión: 1.0
# Uso: ./setup-nuevo-proyecto.sh [nombre-proyecto]

set -e  # Salir si hay error

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Shopify Chatbot Setup Automático  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Verificar nombre del proyecto
if [ -z "$1" ]; then
  echo -e "${YELLOW}Uso: ./setup-nuevo-proyecto.sh [nombre-proyecto]${NC}"
  echo -e "Ejemplo: ./setup-nuevo-proyecto.sh mi-chatbot-shopify"
  exit 1
fi

PROJECT_NAME=$1

echo -e "${GREEN}✓${NC} Creando proyecto: ${BLUE}$PROJECT_NAME${NC}"

# PASO 1: Crear directorio y estructura
echo ""
echo -e "${BLUE}📁 PASO 1: Creando estructura de directorios...${NC}"
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME
mkdir -p widget api lib docs shopify-theme

echo -e "${GREEN}✓${NC} Estructura creada"

# PASO 2: Inicializar Git
echo ""
echo -e "${BLUE}🔧 PASO 2: Inicializando Git...${NC}"
git init

# PASO 3: Inicializar npm
echo ""
echo -e "${BLUE}📦 PASO 3: Inicializando npm...${NC}"
npm init -y

# PASO 4: Instalar dependencias
echo ""
echo -e "${BLUE}📥 PASO 4: Instalando dependencias...${NC}"
npm install groq-sdk dotenv

echo -e "${GREEN}✓${NC} Dependencias instaladas"

# PASO 5: Crear .gitignore
echo ""
echo -e "${BLUE}🔒 PASO 5: Creando .gitignore...${NC}"
cat > .gitignore << 'EOF'
node_modules/
.env
.env.local
.DS_Store
.vercel/
*.log
*.backup
*.bak
EOF

# PASO 6: Crear vercel.json
echo ""
echo -e "${BLUE}⚙️  PASO 6: Creando vercel.json...${NC}"
cat > vercel.json << 'EOF'
{
  "version": 2,
  "builds": [
    {
      "src": "api/**/*.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api/$1"
    }
  ]
}
EOF

# PASO 7: Crear README
echo ""
echo -e "${BLUE}📝 PASO 7: Creando README.md...${NC}"
cat > README.md << EOF
# 🤖 $PROJECT_NAME

Chatbot inteligente para Shopify con IA (Groq/Llama 3.1)

## 🚀 Setup Rápido

1. Configurar variables de entorno:
   - Copiar \`.env.example\` a \`.env.local\`
   - Agregar tus API keys

2. Deploy a Vercel:
   \`\`\`bash
   vercel --prod
   \`\`\`

3. Subir a Shopify:
   \`\`\`bash
   shopify theme push --store=tu-tienda
   \`\`\`

## 📚 Documentación

Ver \`docs/SETUP.md\` para guía completa.

## 🎨 Features

✅ Conversación con IA
✅ Búsqueda de productos
✅ Carrito funcional
✅ Tracking de pedidos
✅ Diseño responsive

---

**Creado con:** [shopify-chatbot-backend](https://github.com/jotamartel/shopify-chatbot-backend)
EOF

# PASO 8: Crear archivos del widget
echo ""
echo -e "${BLUE}🎨 PASO 8: Creando archivos del widget...${NC}"

echo "Creando chatbot-widget.css..."
cat > widget/chatbot-widget.css << 'EOF'
:root {
  --chatbot-primary: #3b82f6;
  --chatbot-bg: #ffffff;
}

#chatbot-button {
  position: fixed;
  bottom: 24px;
  right: 24px;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--chatbot-primary) 0%, #2563eb 100%);
  border: none;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 9999;
}

.chatbot-window {
  position: fixed;
  bottom: 24px;
  right: 24px;
  width: 380px;
  height: 650px;
  background: var(--chatbot-bg);
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  display: none;
  flex-direction: column;
  z-index: 9999;
}

.chatbot-window.open {
  display: flex;
}

/* Agregar más estilos según necesites */
EOF

echo "Creando chatbot-widget.js..."
cat > widget/chatbot-widget.js << 'EOF'
class ShopifyChatbot {
  constructor(config) {
    this.apiEndpoint = config.apiEndpoint;
    this.shop = config.shop;
    this.storeName = config.storeName || 'Tienda';
    this.sessionId = this.generateSessionId();
    this.init();
  }

  generateSessionId() {
    return 'session_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
  }

  init() {
    console.log('Chatbot inicializado');
    // TODO: Crear widget HTML
    // TODO: Attach event listeners
  }
}

if (typeof window !== 'undefined' && window.chatbotConfig) {
  window.chatbot = new ShopifyChatbot(window.chatbotConfig);
}
EOF

# PASO 9: Crear archivos del backend
echo ""
echo -e "${BLUE}🔧 PASO 9: Creando archivos del backend...${NC}"

cat > lib/prompts.js << 'EOF'
export const generateSystemPrompt = (storeName) => {
  return `Eres un asistente virtual para ${storeName}. Responde en español de manera amigable.`;
};
EOF

cat > lib/shopify.js << 'EOF'
export async function searchProducts(query) {
  // TODO: Implementar con Shopify API
  return [];
}
EOF

cat > api/chat.js << 'EOF'
export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  const { message } = req.body;
  
  return res.status(200).json({
    success: true,
    message: 'Hola, soy tu asistente virtual. ¿En qué puedo ayudarte?',
    quickReplies: ['Ver productos', 'Ayuda']
  });
}
EOF

# PASO 10: Crear archivos de Shopify
echo ""
echo -e "${BLUE}🛍️  PASO 10: Creando archivos para Shopify...${NC}"

cat > shopify-theme/chatbot-widget.liquid << 'EOF'
<!-- Chatbot Widget -->
<script>
  window.chatbotConfig = {
    apiEndpoint: 'TU_URL_DE_VERCEL/api/chat',
    shop: '{{ shop.permanent_domain }}',
    storeName: '{{ shop.name }}'
  };
</script>
{{ 'chatbot-widget.css' | asset_url | stylesheet_tag }}
<script src="{{ 'chatbot-widget.js' | asset_url }}" defer></script>
EOF

# PASO 11: Crear .env.example
echo ""
echo -e "${BLUE}🔐 PASO 11: Creando .env.example...${NC}"

cat > .env.example << 'EOF'
# Groq AI
GROQ_API_KEY=tu_groq_api_key_aqui

# Shopify
SHOPIFY_STORE_DOMAIN=tu-tienda.myshopify.com
SHOPIFY_STOREFRONT_TOKEN=tu_token_aqui
STORE_NAME=Tu Tienda

# Config
CHATBOT_LANGUAGE=es
NODE_ENV=development
EOF

cat > .env.local << 'EOF'
# Groq AI
GROQ_API_KEY=

# Shopify
SHOPIFY_STORE_DOMAIN=
SHOPIFY_STOREFRONT_TOKEN=
STORE_NAME=

# Config
CHATBOT_LANGUAGE=es
NODE_ENV=development
EOF

# PASO 12: Crear documentación
echo ""
echo -e "${BLUE}📚 PASO 12: Creando documentación...${NC}"

cat > docs/SETUP.md << 'EOF'
# Setup Guide

## 1. Obtener API Keys

### Groq
1. Ir a https://console.groq.com
2. Crear cuenta
3. Generar API key

### Shopify
1. Admin → Apps → Develop apps
2. Create app
3. Configure Storefront API
4. Generate token

## 2. Configurar

Editar `.env.local` con tus keys

## 3. Deploy

\`\`\`bash
vercel --prod
shopify theme push
\`\`\`
EOF

cat > docs/DEPLOYMENT.md << 'EOF'
# Deployment Guide

## Vercel

\`\`\`bash
vercel login
vercel
vercel env add GROQ_API_KEY
vercel --prod
\`\`\`

## Shopify

\`\`\`bash
shopify login --store tu-tienda
shopify theme pull --store=tu-tienda
cp widget/* tu-tema/assets/
shopify theme push --store=tu-tienda
\`\`\`
EOF

# PASO 13: Commit inicial
echo ""
echo -e "${BLUE}💾 PASO 13: Creando commit inicial...${NC}"
git add .
git commit -m "🎉 Setup inicial del proyecto

- Estructura base
- Widget frontend
- Backend API
- Configuración Vercel
- Archivos Shopify
- Documentación

Generado con: shopify-chatbot-backend/setup-nuevo-proyecto.sh"

# FINALIZACIÓN
echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        ✅ SETUP COMPLETADO!          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}📁 Proyecto creado en:${NC} $PROJECT_NAME/"
echo ""
echo -e "${YELLOW}📝 PRÓXIMOS PASOS:${NC}"
echo ""
echo -e "1️⃣  Configurar variables de entorno:"
echo -e "   ${BLUE}cd $PROJECT_NAME${NC}"
echo -e "   ${BLUE}nano .env.local${NC}  (agregar tus API keys)"
echo ""
echo -e "2️⃣  Instalar CLIs si no los tienes:"
echo -e "   ${BLUE}npm install -g vercel @shopify/cli${NC}"
echo ""
echo -e "3️⃣  Deploy a Vercel:"
echo -e "   ${BLUE}vercel login${NC}"
echo -e "   ${BLUE}vercel${NC}"
echo -e "   ${BLUE}vercel --prod${NC}"
echo ""
echo -e "4️⃣  Subir a Shopify:"
echo -e "   ${BLUE}shopify login --store tu-tienda${NC}"
echo -e "   ${BLUE}shopify theme pull --store=tu-tienda${NC}"
echo -e "   ${BLUE}cp widget/* tu-tema/assets/${NC}"
echo -e "   ${BLUE}shopify theme push --store=tu-tienda${NC}"
echo ""
echo -e "5️⃣  Testing:"
echo -e "   ${BLUE}vercel dev${NC}  (para test local)"
echo ""
echo -e "${GREEN}📚 Documentación completa en:${NC}"
echo -e "   - docs/SETUP.md"
echo -e "   - docs/DEPLOYMENT.md"
echo -e "   - STARTER-KIT-CHATBOT-SHOPIFY.md (en repo original)"
echo ""
echo -e "${BLUE}🎉 ¡Listo para personalizar!${NC}"
echo ""

