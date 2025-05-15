FROM bitnami/node:22.15.0-debian-12-r1

RUN apt-get upgrade && \
    apt-get update -y && \
    apt-get install -y \
        libglib2.0-0 \
        libnss3 \
        libx11-xcb1 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        libatk-bridge2.0-0 \
        libgtk-3-0 \
        libasound2 \
        libdrm2 \
        libxshmfence1 \
        libgbm1 \
        libu2f-udev \
        libpci3 \
        xdg-utils \
        fonts-liberation \
        libappindicator3-1 \
        chromium-driver chromium

RUN groupadd -r test-agent && useradd -m -r -g test-agent test-agent
WORKDIR /home/test-agent
# COPY ./webdriver-io .

RUN mkdir /home/test-agent/test \
    && mkdir /home/test-agent/reports 
COPY ./webdriver-io/test /home/test-agent/test
COPY ./webdriver-io/package.json .
COPY ./webdriver-io/package-lock.json .
COPY ./webdriver-io/tsconfig.json .
COPY ./webdriver-io/wdio.conf.ts .

RUN npm install -y

# USER test-agent

CMD ["tail", "-f", "/dev/null"]