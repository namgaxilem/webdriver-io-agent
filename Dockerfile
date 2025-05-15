FROM node:24.0.1-slim

# Install system packages
USER root

RUN apt-get update -y && \
    apt-get upgrade -y && \
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
        chromium \
        curl \
        git \
        dumb-init

# Create user and working directory
RUN groupadd -r test-agent && useradd -m -r -g test-agent test-agent
WORKDIR /home/test-agent

# Copy project files
COPY ./webdriver-io/package.json ./
COPY ./webdriver-io/package-lock.json ./

# Clean install with no cache
RUN npm cache clean --force && \
    rm -rf node_modules && \
    npm install --no-audit --prefer-online

# Copy source files after install to avoid cache busting
COPY ./webdriver-io/test ./test
COPY ./webdriver-io/tsconfig.json ./tsconfig.json
COPY ./webdriver-io/wdio.conf.ts ./wdio.conf.ts

# Switch to unprivileged user
USER test-agent

CMD ["tail", "-f", "/dev/null"]
