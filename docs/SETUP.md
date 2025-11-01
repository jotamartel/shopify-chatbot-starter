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
