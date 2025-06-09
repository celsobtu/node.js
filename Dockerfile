# Usa uma imagem oficial do Node.js como base.
# 'lts-alpine' é uma boa escolha: leve, segura e estável (LTS - Long Term Support).
FROM node:lts-alpine

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos package.json e package-lock.json para o diretório de trabalho.
# Isso permite que o Docker use o cache de camadas para as dependências
# se apenas o código-fonte for alterado, não as dependências.
COPY package*.json ./

# Instala as dependências do projeto.
# `--only=production` instala apenas as dependências listadas em 'dependencies'
# e não as 'devDependencies', otimizando o tamanho da imagem.
RUN npm install --only=production

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta em que a aplicação Node.js estará escutando.
# Certifique-se de que esta porta corresponde à porta que seu server.js está escutando (ex: process.env.PORT || 3000)
EXPOSE 3000

# Define o comando que será executado quando o contêiner for iniciado.
# 'node server.js' inicia a sua aplicação Node.js.
CMD ["node", "server.js"]
