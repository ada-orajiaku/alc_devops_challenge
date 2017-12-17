# Tells the Docker which base image to start.

FROM ubuntu:14.04
MAINTAINER Adaobi Frank

LABEL Description="Dockerfile for ALC devops challenge"

# Exposing ports for Node.js (3000) and MongoDB (27017) 
EXPOSE 3000 27017 

# Install prerequisites
RUN apt-get -q update && apt-get install -y -qq \
  git \
  curl \
  ssh \
  gcc \
  make \
  build-essential \
  sudo \
  apt-utils \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get install -y mongodb
RUN mkdir -p /data/db
RUN chown -R mongodb:mongodb /data/db

RUN service mongodb start

ADD createdb.js /tmp/

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
  && apt-get install -y -q nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN mkdir /usr/src/UserManager

RUN git clone https://github.com/BolajiOlajide/UserManager.git /usr/src/UserManager/

WORKDIR /usr/src/UserManager

RUN npm install --quiet \
  && npm cache clean


RUN npm start 

#CMD [ "npm", "start" ]
