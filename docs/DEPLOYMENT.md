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
