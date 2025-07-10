FROM python:3.9-slim

WORKDIR /app

# Instalar dependencias del sistema necesarias para paquetes con C extensions como tgcrypto
RUN apt-get update && \
    apt-get install -y ffmpeg jq python3-dev build-essential libffi-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Copiar e instalar dependencias Python
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt

# Copiar el código fuente
COPY . .

# Verificar instalación correcta
RUN python3 -m pip check

# Comando por defecto al iniciar el contenedor
CMD ["python3", "bot.py"]
