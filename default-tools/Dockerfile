FROM ubuntu:latest

# Default to UTF-8 file.encoding
ENV LANG='de_CH.UTF-8' LANGUAGE='de_CH:de' LC_ALL='de_CH.UTF-8'

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
