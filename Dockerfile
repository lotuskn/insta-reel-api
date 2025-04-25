FROM node:18-slim

# Evita o download automático do Chromium pelo Puppeteer
ENV PUPPETEER_SKIP_DOWNLOAD=true 

# Instala bibliotecas necessárias para rodar Puppeteer
RUN apt update && \
    apt install -y \
    libgconf-2-4 libatk1.0-0 libatk-bridge2.0-0 \
    libgdk-pixbuf2.0-0 libgtk-3-0 libgbm-dev \
    libnss3 libxss1 libasound2 && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Diretório de trabalho
WORKDIR /app

# Instala dependências
COPY package-lock.json .
COPY package.json .
RUN npm ci

# Copia o restante dos arquivos
COPY . .

# Expõe a porta (ajuste se necessário)
EXPOSE 8080

# Comando de inicialização
CMD ["node", "src/index.mjs"]
