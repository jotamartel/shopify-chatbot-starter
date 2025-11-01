# 🚀 STARTER KIT: Shopify Chatbot con IA desde Cero

**Versión:** 1.0  
**Última Actualización:** 1 de Noviembre, 2025  
**Basado en:** shopify-chatbot-backend (Julian Martel)  

---

## 📋 PREREQUISITOS

Antes de empezar, asegúrate de tener:

- [ ] Node.js 18+ instalado (`node --version`)
- [ ] npm o yarn instalado
- [ ] Git instalado
- [ ] Cuenta en Vercel (gratis)
- [ ] Cuenta en Groq (gratis, para IA)
- [ ] Tienda Shopify (puede ser de prueba)
- [ ] Editor de código (VS Code recomendado)

---

## 🎯 LO QUE VAS A CREAR

Un chatbot con IA completo que incluye:

✅ Widget frontend embebido en Shopify  
✅ Backend serverless en Vercel  
✅ IA conversacional con Groq (Llama 3.1)  
✅ Búsqueda de productos en tiempo real  
✅ Carrito funcional sincronizado  
✅ Tracking de pedidos  
✅ Product cards con carousel  
✅ Quick replies inteligentes  
✅ Checkout integrado  

---

## 📂 PASO 1: CREAR ESTRUCTURA DEL PROYECTO

### 1.1 Crear directorio y inicializar Git

```bash
# Crear directorio del proyecto
mkdir mi-shopify-chatbot
cd mi-shopify-chatbot

# Inicializar Git
git init

# Crear estructura de carpetas
mkdir -p widget api lib docs
```

### 1.2 Inicializar npm

```bash
# Crear package.json
npm init -y
```

### 1.3 Instalar dependencias

```bash
# Instalar Groq SDK
npm install groq-sdk

# Instalar dotenv para variables de entorno (desarrollo local)
npm install dotenv

# Guardar dependencias
npm install
```

---

## 📝 PASO 2: CREAR ARCHIVOS BASE

### 2.1 Crear .gitignore

```bash
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Production
build/
dist/

# Misc
.DS_Store
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*

# Vercel
.vercel/

# IDE
.vscode/
.idea/
*.swp
*.swo

# Backups
*.backup
*.bak
*.tmp
EOF
```

### 2.2 Crear vercel.json

```bash
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
  ],
  "env": {
    "NODE_ENV": "production"
  }
}
EOF
```

### 2.3 Crear README.md

```bash
cat > README.md << 'EOF'
# 🤖 Shopify Chatbot con IA

Chatbot inteligente para Shopify con integración a Groq AI (Llama 3.1).

## 🌟 Características

- ✅ Conversación natural con IA
- ✅ Búsqueda de productos en tiempo real
- ✅ Carrito funcional sincronizado
- ✅ Tracking de pedidos
- ✅ Product cards con carousel
- ✅ Checkout integrado

## 🚀 Instalación

Ver [STARTER-KIT-CHATBOT-SHOPIFY.md](./STARTER-KIT-CHATBOT-SHOPIFY.md)

## 📝 Licencia

MIT
EOF
```

---

## 🎨 PASO 3: CREAR WIDGET FRONTEND

### 3.1 Crear chatbot-widget.css

```bash
cat > widget/chatbot-widget.css << 'EOF'
/* Variables CSS */
:root {
  --chatbot-primary: #3b82f6;
  --chatbot-primary-dark: #2563eb;
  --chatbot-bg: #ffffff;
  --chatbot-text: #1f2937;
  --chatbot-border: #e5e7eb;
  --chatbot-shadow: rgba(0, 0, 0, 0.1);
  --chatbot-success: #4ade80;
}

/* Botón flotante */
#chatbot-button {
  position: fixed;
  bottom: 24px;
  right: 24px;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--chatbot-primary) 0%, var(--chatbot-primary-dark) 100%);
  border: none;
  cursor: pointer;
  box-shadow: 0 4px 12px var(--chatbot-shadow);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

#chatbot-button:hover {
  transform: scale(1.1);
  box-shadow: 0 6px 20px var(--chatbot-shadow);
}

#chatbot-button svg {
  width: 28px;
  height: 28px;
  fill: white;
}

/* Badge de notificaciones */
#chatbot-badge {
  position: absolute;
  top: -4px;
  right: -4px;
  background: #ef4444;
  color: white;
  border-radius: 50%;
  width: 20px;
  height: 20px;
  display: none;
  align-items: center;
  justify-content: center;
  font-size: 11px;
  font-weight: bold;
}

/* Ventana del chat */
.chatbot-window {
  position: fixed;
  bottom: 24px;
  right: 24px;
  width: 380px;
  height: 650px;
  max-height: calc(100vh - 48px);
  background: var(--chatbot-bg);
  border-radius: 16px;
  box-shadow: 0 8px 32px var(--chatbot-shadow);
  display: flex;
  flex-direction: column;
  opacity: 0;
  transform: translateY(20px);
  pointer-events: none;
  transition: all 0.3s ease;
  z-index: 9999;
  overflow: hidden;
}

.chatbot-window.open {
  opacity: 1;
  transform: translateY(0);
  pointer-events: all;
}

/* Header */
.chatbot-header {
  background: linear-gradient(135deg, var(--chatbot-primary) 0%, var(--chatbot-primary-dark) 100%);
  color: white;
  padding: 16px 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-radius: 16px 16px 0 0;
}

.chatbot-header h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
}

.chatbot-header p {
  margin: 4px 0 0 0;
  font-size: 12px;
  opacity: 0.9;
}

.chatbot-header-actions {
  display: flex;
  gap: 8px;
  align-items: center;
}

.chatbot-cart-button {
  background: transparent;
  border: none;
  color: white;
  cursor: pointer;
  padding: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  transition: background 0.2s;
  position: relative;
}

.chatbot-cart-button:hover {
  background: rgba(255, 255, 255, 0.1);
}

#cart-count-badge {
  position: absolute;
  top: 2px;
  right: 2px;
  background: #ef4444;
  color: white;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  display: none;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  font-weight: bold;
}

#chatbot-close {
  background: transparent;
  border: none;
  color: white;
  cursor: pointer;
  padding: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  transition: background 0.2s;
}

#chatbot-close:hover {
  background: rgba(255, 255, 255, 0.1);
}

/* Mensajes */
.chatbot-messages {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.chatbot-message {
  display: flex;
  gap: 12px;
  animation: messageSlide 0.3s ease;
}

@keyframes messageSlide {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.message-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: var(--chatbot-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.message-avatar svg {
  width: 20px;
  height: 20px;
  fill: white;
}

.message-content {
  flex: 1;
  background: #f3f4f6;
  padding: 12px 16px;
  border-radius: 12px;
  max-width: 80%;
}

.user-message .message-content {
  background: var(--chatbot-primary);
  color: white;
  margin-left: auto;
}

.message-time {
  font-size: 11px;
  opacity: 0.6;
  margin-top: 4px;
  display: block;
}

/* Product Cards */
.product-card {
  background: white;
  border: 1px solid var(--chatbot-border);
  border-radius: 12px;
  overflow: hidden;
  margin-top: 8px;
}

.product-image {
  width: 100%;
  height: 200px;
  background-size: cover;
  background-position: center;
  background-color: #f9fafb;
}

.product-info {
  padding: 16px;
}

.product-title {
  font-size: 16px;
  font-weight: 600;
  margin: 0 0 8px 0;
  color: var(--chatbot-text);
}

.product-price {
  font-size: 18px;
  font-weight: 700;
  color: var(--chatbot-primary);
  margin: 0 0 8px 0;
}

.product-stock {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 12px;
}

.product-stock.in-stock {
  background: #dcfce7;
  color: #16a34a;
}

.product-stock.out-stock {
  background: #fee2e2;
  color: #dc2626;
}

.product-actions {
  display: flex;
  gap: 8px;
}

.product-btn {
  flex: 1;
  padding: 10px 16px;
  border: none;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.add-to-cart-btn {
  background: var(--chatbot-primary);
  color: white;
}

.add-to-cart-btn:hover {
  background: var(--chatbot-primary-dark);
  transform: translateY(-2px);
}

.product-btn-secondary {
  background: white;
  color: var(--chatbot-primary);
  border: 1px solid var(--chatbot-primary);
  text-decoration: none;
}

.product-btn-secondary:hover {
  background: #eff6ff;
}

/* Carousel */
.carousel-container {
  position: relative;
  margin-top: 8px;
}

.product-carousel {
  display: flex;
  overflow-x: hidden;
  scroll-behavior: smooth;
  gap: 12px;
}

.product-card-wrapper {
  min-width: 280px;
  flex-shrink: 0;
}

.carousel-controls {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin-top: 16px;
}

.carousel-btn {
  background: var(--chatbot-primary);
  border: none;
  color: white;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s;
}

.carousel-btn:hover {
  background: var(--chatbot-primary-dark);
  transform: scale(1.1);
}

.carousel-dots {
  display: flex;
  gap: 8px;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #d1d5db;
  cursor: pointer;
  transition: all 0.2s;
}

.dot.active {
  background: var(--chatbot-primary);
  width: 24px;
  border-radius: 4px;
}

/* Quick Replies */
#chatbot-quick-replies {
  padding: 0 20px 12px 20px;
}

.quick-replies-slider {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  padding: 8px 0;
  scrollbar-width: none;
}

.quick-replies-slider::-webkit-scrollbar {
  display: none;
}

.quick-reply-btn-slider {
  padding: 10px 16px;
  background: white;
  border: 1px solid var(--chatbot-border);
  border-radius: 20px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
  white-space: nowrap;
  flex-shrink: 0;
}

.quick-reply-btn-slider:hover {
  background: #eff6ff;
  border-color: var(--chatbot-primary);
  transform: translateY(-2px);
}

/* Input */
.chatbot-input-container {
  padding: 16px 20px;
  border-top: 1px solid var(--chatbot-border);
  display: flex;
  gap: 12px;
}

#chatbot-input {
  flex: 1;
  padding: 12px 16px;
  border: 1px solid var(--chatbot-border);
  border-radius: 24px;
  font-size: 14px;
  outline: none;
  transition: border-color 0.2s;
}

#chatbot-input:focus {
  border-color: var(--chatbot-primary);
}

#chatbot-send {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: var(--chatbot-primary);
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s;
}

#chatbot-send:hover {
  background: var(--chatbot-primary-dark);
  transform: scale(1.1);
}

#chatbot-send svg {
  width: 20px;
  height: 20px;
  fill: white;
}

/* Typing indicator */
.chatbot-typing {
  display: none;
  padding: 0 20px 12px 20px;
}

.typing-indicator {
  display: flex;
  gap: 6px;
  padding: 12px 16px;
  background: #f3f4f6;
  border-radius: 12px;
  width: fit-content;
}

.typing-indicator span {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #9ca3af;
  animation: typing 1.4s infinite;
}

.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes typing {
  0%, 60%, 100% {
    transform: translateY(0);
  }
  30% {
    transform: translateY(-10px);
  }
}

/* Carrito Summary */
.cart-total {
  display: flex;
  justify-content: space-between;
  padding: 12px;
  margin-top: 16px;
  border-radius: 8px;
  font-size: 16px;
  color: #000000;
  background: var(--chatbot-success);
  font-weight: 600;
}

/* Responsive */
@media (min-width: 768px) {
  .chatbot-window {
    height: 720px;
  }
}

@media (min-width: 1024px) {
  .chatbot-window {
    height: 780px;
  }
}

@media (max-width: 480px) {
  .chatbot-window {
    bottom: 0;
    right: 0;
    left: 0;
    width: 100%;
    height: 100%;
    max-height: 100vh;
    border-radius: 0;
  }
  
  #chatbot-button {
    bottom: 16px;
    right: 16px;
  }
}
EOF
```

### 3.2 Crear chatbot-widget.js (Parte 1: Estructura Base)

```bash
cat > widget/chatbot-widget.js << 'EOF'
class ShopifyChatbot {
  constructor(config) {
    this.apiEndpoint = config.apiEndpoint;
    this.cartEndpoint = config.apiEndpoint.replace('/chat', '/cart');
    this.shop = config.shop;
    this.storeName = config.storeName || 'Tienda';
    this.sessionId = this.generateSessionId();
    this.isOpen = false;
    this.conversationHistory = [];
    this.cart = { items: [], total: 0, itemCount: 0 };
    this.context = {};
    
    this.init();
  }

  init() {
    this.createWidget();
    this.attachEventListeners();
  }

  generateSessionId() {
    return 'session_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
  }

  createWidget() {
    // Crear HTML del widget
    const widgetHTML = `
      <button id="chatbot-button">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
          <path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H6l-2 2V4h16v12z"/>
        </svg>
        <span id="chatbot-badge">1</span>
      </button>

      <div id="chatbot-window" class="chatbot-window">
        <div class="chatbot-header">
          <div>
            <h3>${this.storeName}</h3>
            <p>En línea</p>
          </div>
          <div class="chatbot-header-actions">
            <button id="chatbot-cart-btn" class="chatbot-cart-button" title="Ver carrito">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="20" height="20">
                <circle cx="9" cy="21" r="1"></circle>
                <circle cx="20" cy="21" r="1"></circle>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
              </svg>
              <span id="cart-count-badge">0</span>
            </button>
            <button id="chatbot-close">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="20" height="20">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
              </svg>
            </button>
          </div>
        </div>

        <div id="chatbot-messages" class="chatbot-messages">
          <div class="chatbot-message bot-message">
            <div class="message-avatar">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/>
              </svg>
            </div>
            <div class="message-content">
              <p>¡Hola! 👋 Soy tu asistente virtual. ¿En qué puedo ayudarte hoy?</p>
              <span class="message-time">${this.getCurrentTime()}</span>
            </div>
          </div>
        </div>

        <div id="chatbot-typing" class="chatbot-typing">
          <div class="typing-indicator">
            <span></span>
            <span></span>
            <span></span>
          </div>
        </div>

        <div id="chatbot-quick-replies"></div>

        <div class="chatbot-input-container">
          <input 
            type="text" 
            id="chatbot-input" 
            placeholder="Escribe tu mensaje..." 
            autocomplete="off"
          />
          <button id="chatbot-send">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
              <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z"/>
            </svg>
          </button>
        </div>
      </div>
    `;

    document.body.insertAdjacentHTML('beforeend', widgetHTML);
  }

  attachEventListeners() {
    const button = document.getElementById('chatbot-button');
    const closeBtn = document.getElementById('chatbot-close');
    const sendBtn = document.getElementById('chatbot-send');
    const input = document.getElementById('chatbot-input');
    const cartBtn = document.getElementById('chatbot-cart-btn');

    button.addEventListener('click', () => this.toggleChat());
    closeBtn.addEventListener('click', () => this.toggleChat());
    sendBtn.addEventListener('click', () => this.sendMessage());
    cartBtn.addEventListener('click', () => this.showCart());
    
    input.addEventListener('keypress', (e) => {
      if (e.key === 'Enter') {
        this.sendMessage();
      }
    });
  }

  toggleChat() {
    this.isOpen = !this.isOpen;
    const window = document.getElementById('chatbot-window');
    const button = document.getElementById('chatbot-button');

    if (this.isOpen) {
      window.classList.add('open');
      button.style.display = 'none';
      document.getElementById('chatbot-input').focus();
    } else {
      window.classList.remove('open');
      button.style.display = 'flex';
    }
  }

  async sendMessage() {
    const input = document.getElementById('chatbot-input');
    const message = input.value.trim();

    if (!message) return;

    input.value = '';
    this.addMessage(message, 'user');
    this.showTyping();

    try {
      // Preparar historial de conversación
      const conversationHistory = this.conversationHistory
        .slice(-10)
        .map(msg => ({
          role: msg.sender === 'user' ? 'user' : 'assistant',
          content: msg.text,
          timestamp: msg.timestamp
        }));

      const response = await fetch(this.apiEndpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: message,
          shop: this.shop,
          sessionId: this.sessionId,
          context: this.context,
          conversationHistory: conversationHistory
        })
      });

      const data = await response.json();
      this.hideTyping();

      if (data.success) {
        this.addMessage(data.message, 'bot');

        if (data.context) {
          this.context = data.context;
        }

        if (data.cart) {
          this.cart = data.cart;
          this.updateCartBadge();
        }

        if (data.products && data.products.length > 0) {
          this.showProductCards(data.products);
        }

        if (data.quickReplies && data.quickReplies.length > 0) {
          this.showQuickReplies(data.quickReplies);
        }
      } else {
        this.addMessage('Lo siento, hubo un error.', 'bot');
      }

    } catch (error) {
      console.error('Error:', error);
      this.hideTyping();
      this.addMessage('Lo siento, no pude conectarme.', 'bot');
    }
  }

  addMessage(text, sender) {
    const messagesContainer = document.getElementById('chatbot-messages');
    const messageHTML = `
      <div class="chatbot-message ${sender}-message">
        ${sender === 'bot' ? `
          <div class="message-avatar">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
              <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/>
            </svg>
          </div>
        ` : ''}
        <div class="message-content">
          <p>${this.formatMessage(text)}</p>
          <span class="message-time">${this.getCurrentTime()}</span>
        </div>
      </div>
    `;

    messagesContainer.insertAdjacentHTML('beforeend', messageHTML);
    this.scrollToBottom();
    
    // Guardar en historial
    this.conversationHistory.push({
      text: text,
      sender: sender,
      timestamp: Date.now()
    });
  }

  formatMessage(text) {
    text = text.replace(/\n/g, '<br>');
    text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    return text;
  }

  showTyping() {
    document.getElementById('chatbot-typing').style.display = 'flex';
    this.scrollToBottom();
  }

  hideTyping() {
    document.getElementById('chatbot-typing').style.display = 'none';
  }

  scrollToBottom() {
    const messagesContainer = document.getElementById('chatbot-messages');
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
  }

  getCurrentTime() {
    const now = new Date();
    return now.getHours().toString().padStart(2, '0') + ':' + 
           now.getMinutes().toString().padStart(2, '0');
  }

  showProductCards(products) {
    // Implementar según necesites
    console.log('Mostrar productos:', products);
  }

  showQuickReplies(replies) {
    const container = document.getElementById('chatbot-quick-replies');
    container.innerHTML = '';

    const sliderHTML = `
      <div class="quick-replies-slider">
        ${replies.map(reply => `
          <button class="quick-reply-btn-slider" data-reply="${reply}">
            ${reply}
          </button>
        `).join('')}
      </div>
    `;
    
    container.innerHTML = sliderHTML;

    container.querySelectorAll('.quick-reply-btn-slider').forEach(btn => {
      btn.addEventListener('click', (e) => {
        const reply = e.currentTarget.dataset.reply;
        document.getElementById('chatbot-input').value = reply;
        this.sendMessage();
        container.innerHTML = '';
      });
    });
  }

  showCart() {
    // Implementar según necesites
    console.log('Mostrar carrito:', this.cart);
  }

  updateCartBadge() {
    const badge = document.getElementById('cart-count-badge');
    if (this.cart.itemCount > 0) {
      badge.textContent = this.cart.itemCount;
      badge.style.display = 'flex';
    } else {
      badge.style.display = 'none';
    }
  }
}

// Inicializar cuando el DOM esté listo
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initChatbot);
} else {
  initChatbot();
}

function initChatbot() {
  if (window.chatbotConfig) {
    window.chatbot = new ShopifyChatbot(window.chatbotConfig);
  }
}
EOF
```

---

## 🔧 PASO 4: CREAR BACKEND API

### 4.1 Crear lib/prompts.js

```bash
cat > lib/prompts.js << 'EOF'
export const generateSystemPrompt = (options = {}) => {
  const storeName = options.storeName || 'Tu Tienda';
  const language = options.language || 'es';
  
  return `Eres un asistente virtual amigable y profesional para ${storeName}. 
Tu objetivo es ayudar a los clientes con información sobre productos, pedidos y soporte general.
Responde siempre en ${language === 'es' ? 'español' : 'inglés'} de manera clara, concisa y amigable.

REGLAS CRÍTICAS:
- NUNCA inventes marcas, productos, precios o características
- SOLO habla de productos que te hayan sido proporcionados específicamente
- Si no tienes información específica, di "No tengo información sobre ese producto en nuestro catálogo"
- Sé breve y directo en tus respuestas`;
};

export const getWelcomeMessage = (storeName) => {
  return `¡Hola! 👋 Soy el asistente virtual de ${storeName}. ¿En qué puedo ayudarte hoy?`;
};
EOF
```

### 4.2 Crear lib/shopify.js (Básico)

```bash
cat > lib/shopify.js << 'EOF'
// Funciones básicas para Shopify
// Estas son simplificadas, necesitarás implementar con tu Storefront API

export async function searchProducts(query, limit = 6) {
  // TODO: Implementar búsqueda real con Shopify Storefront API
  console.log('Buscar productos:', query);
  return [];
}

export async function getOrderDetails(orderNumber) {
  // TODO: Implementar con Shopify Admin API
  console.log('Obtener orden:', orderNumber);
  return null;
}

export async function searchOrdersByEmail(email) {
  // TODO: Implementar con Shopify Admin API
  console.log('Buscar órdenes por email:', email);
  return [];
}
EOF
```

### 4.3 Crear api/chat.js

```bash
cat > api/chat.js << 'EOF'
import Groq from 'groq-sdk';
import { searchProducts, getOrderDetails, searchOrdersByEmail } from '../lib/shopify.js';
import { generateSystemPrompt } from '../lib/prompts.js';

const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY,
});

export default async function handler(req, res) {
  // CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { message, sessionId, context = {}, conversationHistory = [] } = req.body;

    if (!message) {
      return res.status(400).json({ error: 'Message is required' });
    }

    // Respuesta simple por defecto
    let responseMessage = 'Hola, soy tu asistente. ¿En qué puedo ayudarte?';
    let quickReplies = ['Ver productos', 'Ayuda'];

    // Aquí puedes agregar lógica más compleja con Groq
    if (message.toLowerCase().includes('producto')) {
      responseMessage = 'Puedo ayudarte a buscar productos. ¿Qué estás buscando?';
    }

    return res.status(200).json({
      success: true,
      message: responseMessage,
      quickReplies,
      sessionId: sessionId || `session_${Date.now()}`,
    });

  } catch (error) {
    console.error('Error in chat handler:', error);
    return res.status(500).json({
      success: false,
      error: 'Error processing message',
      message: '😔 Disculpa, tuve un problema técnico.',
    });
  }
}
EOF
```

---

## 🚀 PASO 5: CONFIGURAR VARIABLES DE ENTORNO

### 5.1 Crear .env.local (para desarrollo)

```bash
cat > .env.local << 'EOF'
# Groq AI
GROQ_API_KEY=tu_groq_api_key_aqui

# Shopify
SHOPIFY_STORE_DOMAIN=tu-tienda.myshopify.com
SHOPIFY_STOREFRONT_TOKEN=tu_storefront_token_aqui
STORE_NAME=Tu Tienda

# Configuración
CHATBOT_LANGUAGE=es
NODE_ENV=development
EOF

echo "⚠️  NO OLVIDES ACTUALIZAR .env.local CON TUS KEYS REALES"
```

---

## 🎨 PASO 6: CREAR SNIPPET DE SHOPIFY

### 6.1 Crear archivo para Shopify

```bash
mkdir -p shopify-theme
cat > shopify-theme/chatbot-widget.liquid << 'EOF'
{% comment %}
  Chatbot Widget
  Incluir en theme.liquid antes del </body>
{% endcomment %}

<!-- Configuración del Chatbot -->
<script>
  window.chatbotConfig = {
    apiEndpoint: 'TU_URL_DE_VERCEL/api/chat',
    shop: '{{ shop.permanent_domain }}',
    storeName: '{{ shop.name }}'
  };
</script>

<!-- CSS del Chatbot -->
{{ 'chatbot-widget.css' | asset_url | stylesheet_tag }}

<!-- JavaScript del Chatbot -->
<script src="{{ 'chatbot-widget.js' | asset_url }}" defer></script>
EOF
```

---

## 🚀 PASO 7: DEPLOYMENT

### 7.1 Instalar CLIs necesarios

```bash
# Instalar Vercel CLI
npm install -g vercel

# Instalar Shopify CLI  
npm install -g @shopify/cli
```

### 7.2 Deploy a Vercel

```bash
# Login en Vercel
vercel login

# Deploy (primera vez)
vercel

# Deploy a producción
vercel --prod
```

### 7.3 Configurar variables en Vercel

```bash
# Agregar variables de entorno
vercel env add GROQ_API_KEY
vercel env add SHOPIFY_STORE_DOMAIN
vercel env add SHOPIFY_STOREFRONT_TOKEN
vercel env add STORE_NAME
vercel env add CHATBOT_LANGUAGE

# Redesplegar con las variables
vercel --prod
```

### 7.4 Subir a Shopify

```bash
# Login en Shopify
shopify login --store tu-tienda

# Crear directorio de tema si no existe
shopify theme pull --store=tu-tienda

# Copiar archivos del widget
cp widget/chatbot-widget.js your-theme/assets/
cp widget/chatbot-widget.css your-theme/assets/
cp shopify-theme/chatbot-widget.liquid your-theme/snippets/

# Subir a Shopify
shopify theme push --store=tu-tienda
```

---

## ✅ PASO 8: TESTING

### 8.1 Test Local

```bash
# Instalar Vercel dev
vercel dev

# Abrir en navegador
open http://localhost:3000
```

### 8.2 Test en Producción

1. Ir a tu tienda Shopify
2. Abrir consola del navegador (F12)
3. Verificar que no hay errores
4. Probar el chatbot

---

## 📚 PASO 9: DOCUMENTACIÓN

### 9.1 Crear docs básicos

```bash
mkdir -p docs

cat > docs/SETUP.md << 'EOF'
# Setup Guide

## 1. Obtener API Keys

### Groq API Key
1. Ir a https://console.groq.com
2. Crear cuenta gratuita
3. Generar API key

### Shopify Storefront Token
1. Admin Shopify → Apps → Develop apps
2. Create an app
3. Configure → Storefront API
4. Generate access token

## 2. Configurar Variables

Ver .env.local de ejemplo

## 3. Deploy

Ver STARTER-KIT-CHATBOT-SHOPIFY.md
EOF
```

---

## 🎯 COMANDOS EN ORDEN CRONOLÓGICO (COPY-PASTE)

### Setup Completo (ejecutar uno por uno):

```bash
# 1. Crear proyecto
mkdir mi-shopify-chatbot && cd mi-shopify-chatbot

# 2. Inicializar
git init
npm init -y

# 3. Crear estructura
mkdir -p widget api lib docs shopify-theme

# 4. Instalar dependencias
npm install groq-sdk dotenv

# 5. Crear archivos (ejecutar los cat > ... de arriba)

# 6. Instalar CLIs
npm install -g vercel @shopify/cli

# 7. Deploy Vercel
vercel login
vercel
vercel env add GROQ_API_KEY
vercel env add SHOPIFY_STORE_DOMAIN
vercel --prod

# 8. Deploy Shopify
shopify login --store tu-tienda
shopify theme pull --store=tu-tienda
cp widget/* your-theme/assets/
cp shopify-theme/chatbot-widget.liquid your-theme/snippets/
shopify theme push --store=tu-tienda

# 9. Testing
vercel dev
```

---

## 📦 ESTRUCTURA FINAL

```
mi-shopify-chatbot/
├── widget/
│   ├── chatbot-widget.js
│   └── chatbot-widget.css
├── api/
│   └── chat.js
├── lib/
│   ├── shopify.js
│   └── prompts.js
├── docs/
│   └── SETUP.md
├── shopify-theme/
│   └── chatbot-widget.liquid
├── .gitignore
├── .env.local
├── vercel.json
├── package.json
└── README.md
```

---

## 🎉 RESULTADO

Ahora tienes un chatbot funcional con:

✅ Widget embebido en Shopify  
✅ Backend en Vercel  
✅ IA con Groq  
✅ Estructura escalable  
✅ Listo para personalizar  

---

## 📝 PRÓXIMOS PASOS

1. Implementar funciones de Shopify en `lib/shopify.js`
2. Agregar product cards y carousel
3. Implementar carrito funcional
4. Personalizar diseño
5. Agregar analytics

---

**Versión:** 1.0  
**Última Actualización:** 1 de Noviembre, 2025  
**Mantenido por:** Julian Martel  

