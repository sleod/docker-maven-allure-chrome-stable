FROM maven:3.9.2-eclipse-temurin-17

# Google Chrome

ARG CHROME_VERSION_STABLE=117.0.5938.92

RUN apt-get update -qqy \
	&& apt-get -qqy install gpg unzip \
	&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update -qqy \
	&& apt-get -qqy install google-chrome-stable=$CHROME_VERSION_STABLE \
	&& rm /etc/apt/sources.list.d/google-chrome.list \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& sed -i 's/"$HERE\/chrome"/"$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

# ChromeDriver

RUN wget -q -O /tmp/chromedriver.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_VERSION_STABLE/linux64/chromedriver-linux64.zip \
	&& unzip /tmp/chromedriver.zip -d /opt \
	&& rm /tmp/chromedriver.zip \
	&& mv /opt/chromedriver /opt/chromedriver-$CHROME_VERSION_STABLE \
	&& chmod 755 /opt/chromedriver-$CHROME_VERSION_STABLE \
	&& ln -s /opt/chromedriver-$CHROME_VERSION_STABLE /usr/bin/chromedriver
