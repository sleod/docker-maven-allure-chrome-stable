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
    ca-certificates \
    apt-transport-https \
    lsb-release \
    libxss1 \
    libxshmfence1 \
    libgbm-dev \
    libx11-xcb1 \
    xauth \
    xvfb \
    xdg-utils \
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

ARG CHROME_VERSION_STABLE=136.0.7103.92
# ChromeDriver https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION_STABLE/linux64/chromedriver-linux64.zip
RUN wget -q -O /tmp/chromedriver.zip https://storage.googleapis.com/chrome-for-testing-public/${CHROME_VERSION_STABLE}/linux64/chromedriver-linux64.zip \
	&& unzip /tmp/chromedriver.zip -d /opt \
	&& rm /tmp/chromedriver.zip \
	&& chmod 755 /opt/chromedriver-linux64/chromedriver \
	&& ln -s /opt/chromedriver-linux64/chromedriver /usr/bin/chromedriver

#Verify Install
RUN echo Verifying install ... \
    && fileEncoding="$(echo 'System.out.println(System.getProperty("file.encoding"))' | jshell -s -)"; [ "$fileEncoding" = 'UTF-8' ]; rm -rf ~/.java \
    && echo java --version && java --version

# Allure CLi
ARG ALLURE_VERSION=2.33.0
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

## Install Maven manually
#ARG MAVEN_VERSION=3.9.6
#
#RUN wget https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip -O /tmp/maven.zip && \
#    unzip /tmp/maven.zip -d /opt && \
#    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
#    ln -s /opt/maven/bin/mvn /usr/bin/mvn && \
#    rm /tmp/maven.zip
#
##Set MAVEN
#ENV MAVEN_HOME /opt/maven
#ENV PATH $MAVEN_HOME/bin:$PATH
#
#ARG USER_HOME_DIR="/root"
#ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# Install Node.js LTS (v18)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm

#Install Playwright
#Env
ENV PLAYWRIGHT_BROWSERS_PATH=/opt/ms-playwright
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=true
ARG PLAYWRIGHT_VERSION=1.51.0

# Install Playwright and its dependencies
RUN npm install -g playwright && \
    mkdir -p $PLAYWRIGHT_BROWSERS_PATH && \
    && chmod 755 $PLAYWRIGHT_BROWSERS_PATH \
    playwright install --with-deps

# Final directory to work in
WORKDIR /app

# Default command
CMD ["bash"]
