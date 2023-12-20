FROM ubuntu:latest

# Default to UTF-8 file.encoding
ENV LANG='de_CH.UTF-8'

# common for all images
RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -f \
 	&& apt-get install wget -qqy \
 	&& apt-get install curl -qqy \
   	&& apt-get install file -qqy \
  	&& apt-get install ruby-full -qqy \
   	&& apt-get install git -qqy \
    	&& apt-get install -y locales locales-all

RUN gem install babelish

RUN babelish --help

RUN file --help

# JDK 17
RUN apt-get update -qqy \
	&& apt-get install openjdk-17-jdk -qqy
 
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

RUN echo Verifying install ... \
    && fileEncoding="$(echo 'System.out.println(System.getProperty("file.encoding"))' | jshell -s -)"; [ "$fileEncoding" = 'UTF-8' ]; rm -rf ~/.java \
    && echo java --version && java --version \
    && echo $JAVA_HOME.

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
