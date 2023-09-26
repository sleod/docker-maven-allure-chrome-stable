FROM maven:3.9.2-eclipse-temurin-17

# Google Chrome

ARG CHROME_VERSION_STABLE=117.0.5938.92

RUN apt update -y \
	&& apt upgrade -y \
	&& apt-get update -qqy \
	&& apt-get -qqy install gpg unzip \
	&& wget -q -O /tmp/google.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 	&& apt install -f \
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
