FROM ubuntu:latest

# common for all images
RUN apt-get update -qqy \
	&& apt-get upgrade -qqy \
	&& apt-get install -f

ENV JAVA_HOME /opt/java/openjdk
ENV PATH $JAVA_HOME/bin:$PATH

# Default to UTF-8 file.encoding
ENV LANG='de_CH.UTF-8' LANGUAGE='de_CH:de' LC_ALL='de_CH.UTF-8'

# JDK 17
RUN apt install openjdk-17-jdk

RUN echo Verifying install ... \
    && fileEncoding="$(echo 'System.out.println(System.getProperty("file.encoding"))' | jshell -s -)"; [ "$fileEncoding" = 'UTF-8' ]; rm -rf ~/.java \
    && echo javac --version && javac --version \
    && echo java --version && java --version \
    && echo Complete.

RUN yum install -y tar which gzip

# MAVENok
ENV MAVEN_HOME /usr/share/maven

COPY --from=maven:3.9.4-eclipse-temurin-11 ${MAVEN_HOME} ${MAVEN_HOME}
COPY --from=maven:3.9.4-eclipse-temurin-11 /usr/local/bin/mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY --from=maven:3.9.4-eclipse-temurin-11 /usr/share/maven/ref/settings-docker.xml /usr/share/maven/ref/settings-docker.xml

RUN ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn

ARG MAVEN_VERSION=3.9.4
ARG USER_HOME_DIR="/root"
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# Google Chrome
ARG CHROME_VERSION_STABLE=117.0.5938.92

RUN apt-get -qqy install gpg unzip \
	&& wget -q -O /tmp/google.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 	&& dpkg -i /tmp/google.deb \
	&& rm /tmp/google.deb \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& google-chrome --version

# ChromeDriver
RUN wget -q -O /tmp/chromedriver.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_VERSION_STABLE/linux64/chromedriver-linux64.zip \
	&& unzip /tmp/chromedriver.zip -d /opt \
	&& rm /tmp/chromedriver.zip \
	&& mv /opt/chromedriver /opt/chromedriver-$CHROME_VERSION_STABLE \
	&& chmod 755 /opt/chromedriver-$CHROME_VERSION_STABLE \
	&& ln -s /opt/chromedriver-$CHROME_VERSION_STABLE /usr/bin/chromedriver
