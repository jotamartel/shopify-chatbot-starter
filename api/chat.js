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
