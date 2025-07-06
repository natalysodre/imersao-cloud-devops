# 1. Use uma imagem base oficial do Python.
# A tag 'slim' é uma boa opção por ser menor que a padrão, mas ainda ter as ferramentas básicas.
# O README especifica Python 3.10 ou superior.
FROM python:3.10-slim

# 2. Defina o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copie o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# 4. Instale as dependências.
# --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copie o resto do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Exponha a porta em que o Uvicorn será executado.
EXPOSE 8000

# 7. Comando para executar a aplicação.
# Use 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]