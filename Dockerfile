# Python 3.9 tabanlı imajı kullan
FROM python:3.9-slim

# Çalışma dizinini ayarla
WORKDIR /app

# Gereksinimlerinizi yüklemek için requirements.txt dosyasını kopyalayın
COPY requirements.txt .

# Python paketlerini yükle
RUN pip install -r requirements.txt

# Uygulamanızı başlatın
CMD ["python", "app.py"]
