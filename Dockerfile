FROM node:lts-alpine
MAINTAINER Michael Nilsen

RUN set -e
RUN apk update && apk upgrade
RUN apk add bash
RUN apk add git
RUN apk add pwgen
RUN apk add sed

RUN addgroup -S app && adduser -S -G app app
ENV HOME=/home/app

RUN npm install -g n forever

ENV ADMIN_PWD sysdevl1
#ENV ACTIVE_FEED mta_subway
#ENV SERVER_PORT 16181
#ENV BUILD true

RUN mkdir $HOME/MTA_Subway_SIRI_Server
COPY package.json $HOME/MTA_Subway_SIRI_Server
RUN chown -R app:app $HOME/*

WORKDIR $HOME/MTA_Subway_SIRI_Server
RUN npm install --production

COPY --chown=app:app . $HOME/MTA_Subway_SIRI_Server
#RUN chown -R app:app $HOME/*
RUN ["/bin/bash","-c","./docker_start.sh"]
RUN more config/server.json
RUN ./bin/updateGTFSData.js

EXPOSE $SERVER_PORT
CMD ["node","siri_server.js"]
