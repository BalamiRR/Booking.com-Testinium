FROM python:3.10

# Google Chrome Kurulumu
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# ChromeDriver Kurulumu
RUN wget -O /tmp/chromedriver.zip https://storage.googleapis.com/chrome-for-testing-public/124.0.6367.60/linux64/chromedriver-linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm /tmp/chromedriver.zip

# Microsoft Edge Kurulumu
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge/ stable main" > /etc/apt/sources.list.d/microsoft-edge.list && \
    apt-get update && \
    apt-get install -y microsoft-edge-stable && \
    rm -rf /var/lib/apt/lists/*

# EdgeDriver Kurulumu
RUN wget -O /tmp/msedgedriver.zip "https://msedgedriver.azureedge.net/124.0.2478.80/edgedriver_linux64.zip" && \
    unzip /tmp/msedgedriver.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/msedgedriver && \
    rm /tmp/msedgedriver.zip

# Gereksinimleri yükle
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Uygulamanın tüm dosyalarını kopyala
COPY . .

# Testleri çalıştırmak için başlat komutu
CMD ["robot", "--output", "results/output.xml", "tests/"]
