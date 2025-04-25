FROM node:18-slim

# Variáveis para instalar dependências
ENV PUPPETEER_SKIP_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Instala bibliotecas necessárias
RUN apt update && \
    apt install -y chromium libgconf-2-4 libatk1.0-0 \
    libatk-bridge2.0-0 libgdk-pixbuf2.0-0 libgtk-3-0 \
    libgbm-dev libnss3 libxss1 libasound2 && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Cria diretório de trabalho
WORKDIR /app

# Copia os arquivos
COPY package*.json ./
RUN npm install

# Copia restante do projeto
COPY . .

# Porta
EXPOSE 8080

# Start
CMD ["node", "src/index.mjs"]
