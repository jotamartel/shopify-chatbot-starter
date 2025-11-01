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
