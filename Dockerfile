FROM python:3
COPY . /app
RUN pip3 install --upgrade pip
RUN pip install --no-cache-dir -r /app/requirements.txt

RUN apt-get update && \
    apt-get install -y firefox-esr && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* && \
    wget -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz && \
    tar -xzf /tmp/geckodriver.tar.gz -C /usr/local/bin/ && \
    rm /tmp/geckodriver.tar.gz

RUN apt-get update && \
    apt-get install -y wget gnupg2 unzip && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/chromedriver.zip https://storage.googleapis.com/chrome-for-testing-public/124.0.6367.60/linux64/chromedriver-linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zipgit

RUN apt-get update && \
    apt-get install -y wget apt-transport-https && \
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge/ stable main" > /etc/apt/sources.list.d/microsoft-edge.list && \
    apt-get update && \
    apt-get install -y microsoft-edge-stable && \
    EDGE_VERSION=$(microsoft-edge --version | awk '{print $3}' | cut -d '.' -f1-2) && \
    echo "Microsoft Edge version: $EDGE_VERSION"

RUN wget -O /tmp/msedgedriver.zip "https://msedgedriver.azureedge.net/124.0.2478.80/edgedriver_linux64.zip" && \
    unzip /tmp/msedgedriver.zip -d /usr/local/bin/ && \
    rm /tmp/msedgedriver.zip  && \
    ls /usr/local/bin/msedgedriver


RUN pip install rpaframework

RUN rm -rf /root/.cache/selenium
ENTRYPOINT ["tail", "-f", "/dev/null"]
