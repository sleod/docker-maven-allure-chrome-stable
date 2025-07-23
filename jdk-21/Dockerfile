FROM maven:3.9.6-eclipse-temurin-21 AS builder

# common for all images
# basic tools and open JDK 21
RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -f \
 	&& apt-get install -y locales \
    && apt-get install -y  wget curl unzip gnupg \
    fonts-liberation libcurl4 libgbm1 libgtk-4-1 libu2f-udev \
    libvulkan1 libxkbcommon0 xdg-utils libnspr4 \
    libnss3 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libasound2 \
    libxss1 \
    libxshmfence1 \
    libgbm-dev \
    libx11-xcb1 \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Google Chrome
RUN  wget -q -O /tmp/google.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 	&& dpkg -i /tmp/google.deb \
	&& rm /tmp/google.deb \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& google-chrome --version

ARG CHROME_VERSION_STABLE=138.0.7204.168
# ChromeDriver https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION_STABLE/linux64/chromedriver-linux64.zip
RUN wget -q -O /tmp/chromedriver.zip https://storage.googleapis.com/chrome-for-testing-public/${CHROME_VERSION_STABLE}/linux64/chromedriver-linux64.zip \
	&& unzip /tmp/chromedriver.zip -d /opt \
	&& rm /tmp/chromedriver.zip \
	&& chmod 755 /opt/chromedriver-linux64/chromedriver \
	&& ln -s /opt/chromedriver-linux64/chromedriver /usr/bin/chromedriver

# Allure CLi
ARG ALLURE_VERSION=2.34.0
ARG REPO_BASE=https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/

#https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/
RUN set -x && tar=allure-commandline-$ALLURE_VERSION.zip \
	&& url=$REPO_BASE$ALLURE_VERSION/$tar \
	&& wget -q -O /tmp/allure.zip $url \
 	&& unzip /tmp/allure.zip -d /opt \
  	&& rm /tmp/allure.zip \
   	&& location=/opt/allure-$ALLURE_VERSION \
	&& chmod 755 $location \
	&& ln -s $location/bin/allure /usr/bin

# Install Node.js LTS (v18)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm

#Install Playwright
#Env
ENV PLAYWRIGHT_BROWSERS_PATH=/opt/ms-playwright
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=true
ARG PLAYWRIGHT_VERSION=1.54.1

# Install Playwright and its dependencies
RUN npm install -g playwright@$PLAYWRIGHT_VERSION \
    && mkdir -p $PLAYWRIGHT_BROWSERS_PATH \
    && chmod 755 $PLAYWRIGHT_BROWSERS_PATH \
    && playwright install --with-deps

# Verify installations
RUN java -version && \
    mvn -version && \
    node -v && \
    npm -v && \
    npx playwright --version

# Final directory to work in
WORKDIR /app

# Default command
CMD ["bash"]
