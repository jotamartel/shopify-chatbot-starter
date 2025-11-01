# 🤖 Shopify Chatbot Starter Kit

**Setup completo en 1 comando** | Chatbot inteligente con IA para Shopify

[![Deploy](https://img.shields.io/badge/Deploy-Vercel-black)](https://vercel.com)
[![Groq](https://img.shields.io/badge/AI-Groq%20%2F%20Llama%203.1-orange)](https://groq.com)
[![Shopify](https://img.shields.io/badge/Platform-Shopify-green)](https://shopify.dev)

---

## ⚡ Quick Start

### Un solo comando para crear tu proyecto:

```bash
./setup-nuevo-proyecto.sh mi-chatbot-shopify
```

**¡Listo!** Tu chatbot completo se crea en 4 segundos.

---

## 🌟 Features

✅ **Conversación natural con IA** (Groq/Llama 3.1)  
✅ **Búsqueda de productos** en tiempo real  
✅ **Carrito funcional** sincronizado con Shopify  
✅ **Tracking de pedidos**  
✅ **Product cards** con carousel  
✅ **Quick replies** inteligentes  
✅ **Checkout integrado**  
✅ **Diseño responsive** (mobile-first)  
✅ **Persistencia de contexto**  

---

## 📦 Lo que incluye

- **Widget Frontend** completo (JS + CSS)
- **Backend Serverless** (Vercel ready)
- **Integración Groq AI** (Llama 3.1)
- **Shopify Storefront API** configurada
- **Documentación completa**
- **Git inicializado**
- **Dependencias instaladas**

---

## 🚀 Setup Completo

### 1️⃣ Ejecutar el script

```bash
git clone https://github.com/jotamartel/shopify-chatbot-starter.git
cd shopify-chatbot-starter
./setup-nuevo-proyecto.sh mi-tienda-chatbot
```

### 2️⃣ Configurar API Keys

```bash
cd mi-tienda-chatbot
nano .env.local
```

Agregar:
- **GROQ_API_KEY** - Obtener en [console.groq.com](https://console.groq.com)
- **SHOPIFY_STOREFRONT_TOKEN** - Crear en Admin Shopify → Apps

### 3️⃣ Deploy

```bash
# Backend (Vercel)
vercel --prod

# Frontend (Shopify)
shopify theme push --store=tu-tienda
```

---

## 📚 Documentación

- 📖 **[STARTER-KIT-CHATBOT-SHOPIFY.md](./STARTER-KIT-CHATBOT-SHOPIFY.md)** - Guía completa paso a paso
- ⚡ **[COMANDOS-RAPIDOS.md](./COMANDOS-RAPIDOS.md)** - Referencia rápida de comandos
- 🔧 **[docs/SETUP.md](./docs/SETUP.md)** - Setup detallado
- 🚀 **[docs/DEPLOYMENT.md](./docs/DEPLOYMENT.md)** - Deployment guide

---

## 🎯 Estructura del Proyecto

```
mi-chatbot/
├── widget/                 ← Frontend (JS + CSS)
├── api/                    ← Backend (Vercel)
├── lib/                    ← Librerías (Shopify + Prompts)
├── docs/                   ← Documentación
├── shopify-theme/          ← Snippet Liquid
└── .env.local              ← Configuración
```

---

## 🛠️ Tech Stack

- **Frontend:** Vanilla JavaScript + CSS
- **Backend:** Node.js + Vercel Serverless
- **IA:** Groq (Llama 3.1 8B)
- **E-commerce:** Shopify Storefront API
- **Deployment:** Vercel + Shopify CLI

---

## 💡 Casos de Uso

### Cliente nuevo
```bash
./setup-nuevo-proyecto.sh cliente-boutique
# Personalizar colores y mensajes
vercel --prod
```

### Demo rápido
```bash
./setup-nuevo-proyecto.sh demo-ventas
vercel dev  # Test local instantáneo
```

### Múltiples tiendas
```bash
./setup-nuevo-proyecto.sh tienda-1
./setup-nuevo-proyecto.sh tienda-2
./setup-nuevo-proyecto.sh tienda-3
# Mismo código base, diferentes configuraciones
```

---

## 🎨 Personalización

### Cambiar colores
```css
/* widget/chatbot-widget.css */
:root {
  --chatbot-primary: #TU_COLOR;
}
```

### Ajustar altura
```css
.chatbot-window {
  height: 700px;
}
```

### Modificar mensajes
```javascript
// widget/chatbot-widget.js
this.addMessage('¡Tu mensaje personalizado!', 'bot');
```

---

## 🐛 Troubleshooting

### Chatbot no aparece
```bash
# Limpiar caché del navegador
Cmd + Shift + R (Mac)
Ctrl + Shift + R (Windows)
```

### API no responde
```bash
# Ver logs de Vercel
vercel logs --follow
```

### Cambios no se reflejan
```bash
# Re-deploy forzado
shopify theme push --store=tu-tienda --allow-live
```

---

## 📞 Soporte

- **Issues:** [GitHub Issues](https://github.com/jotamartel/shopify-chatbot-starter/issues)
- **Docs:** Ver carpeta `docs/`
- **Proyecto Base:** [shopify-chatbot-backend](https://github.com/jotamartel/shopify-chatbot-backend)

---

## 🤝 Contribuir

1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📄 Licencia

MIT License - Ver [LICENSE](LICENSE)

---

## 🌟 Créditos

Desarrollado por [Julian Martel](https://github.com/jotamartel)

**Basado en:** [shopify-chatbot-backend](https://github.com/jotamartel/shopify-chatbot-backend)

---

## ⭐ Star si te fue útil!

Si este starter kit te ayudó, considera darle una ⭐ en GitHub.

---

**¿Preguntas?** Abre un [issue](https://github.com/jotamartel/shopify-chatbot-starter/issues) o revisa la [documentación completa](./STARTER-KIT-CHATBOT-SHOPIFY.md).
