FROM ubuntu:latest

# Default to UTF-8 file.encoding
ENV LANG='de_CH.UTF-8' LANGUAGE='de_CH:de' LC_ALL='de_CH.UTF-8'

# common for all images
RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -f \
 	&& apt-get install wget -qqy \
  	&& apt-get install gzip -qqy \
   	&& apt-get install gpg unzip -qqy


# Google Chrome
RUN apt-get update -y \
	&& apt-get install -y fonts-liberation \
   	&& apt-get install -y libcurl4 \
    	&& apt-get install -y libgbm1 \
     	&& apt-get install -y libgtk-4-1 \
	&& apt-get install -y libu2f-udev \
  	&& apt-get install -y libvulkan1 \
  	&& apt-get install -y libxkbcommon0 \
        && apt-get install -y xdg-utils \
	&& apt-get install -y libnspr4 \
 	&& apt-get install -y libnss3 \
 	&& apt-get install -y libasound2
	
ARG CHROME_VERSION_STABLE=122.0.6261.69

RUN  wget -q -O /tmp/google.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 	&& dpkg -i /tmp/google.deb \
	&& rm /tmp/google.deb \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& google-chrome --version

# ChromeDriver
RUN wget -q -O /tmp/chromedriver.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_VERSION_STABLE/linux64/chromedriver-linux64.zip \
	&& unzip /tmp/chromedriver.zip -d /opt \
	&& rm /tmp/chromedriver.zip \
	&& chmod 755 /opt/chromedriver-linux64/chromedriver \
	&& ln -s /opt/chromedriver-linux64/chromedriver /usr/bin/chromedriver

# JDK 17
RUN apt-get update -qqy \
	&& apt-get install openjdk-17-jdk -qqy
 
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

RUN echo Verifying install ... \
    && fileEncoding="$(echo 'System.out.println(System.getProperty("file.encoding"))' | jshell -s -)"; [ "$fileEncoding" = 'UTF-8' ]; rm -rf ~/.java \
    && echo java --version && java --version \
    && echo $JAVA_HOME.

# Allure CLi
ARG ALLURE_VERSION=2.24.0
ARG REPO_BASE=https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/

#https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/2.24.0/allure-commandline-2.24.0.zip
RUN set -x && tar=allure-commandline-$ALLURE_VERSION.zip \
	&& url=$REPO_BASE$ALLURE_VERSION/$tar \
	&& wget -q -O /tmp/allure.zip $url \
 	&& unzip /tmp/allure.zip -d /opt \
  	&& rm /tmp/allure.zip \
   	&& location=/opt/allure-$ALLURE_VERSION \
	&& chmod 755 $location \
	&& ln -s $location/bin/allure /usr/bin

# MAVEN
ENV MAVEN_HOME /usr/share/maven
ENV PATH $MAVEN_HOME/bin:$PATH

COPY --from=maven:3.9.4-eclipse-temurin-11 ${MAVEN_HOME} ${MAVEN_HOME}
COPY --from=maven:3.9.4-eclipse-temurin-11 /usr/local/bin/mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY --from=maven:3.9.4-eclipse-temurin-11 /usr/share/maven/ref/settings-docker.xml /usr/share/maven/ref/settings-docker.xml

RUN ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn

ARG MAVEN_VERSION=3.9.4
ARG USER_HOME_DIR="/root"
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
