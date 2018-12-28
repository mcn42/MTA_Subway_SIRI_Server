FROM node:lts-alpine
MAINTAINER Michael Nilsen

RUN set -e
RUN apk update && apk upgrade
RUN apk add bash
RUN apk add git

RUN addgroup -S app && adduser -S -G app app
ENV HOME=/home/app

#RUN npm install -g npm
RUN npm install -g n forever
#RUN n lts

RUN mkdir $HOME/MTA_Subway_SIRI_Server
COPY package.json $HOME/MTA_Subway_SIRI_Server
RUN chown -R app:app $HOME/*

WORKDIR $HOME/MTA_Subway_SIRI_Server
RUN npm install --production

COPY . $HOME/MTA_Subway_SIRI_Server
RUN chown -R app:app $HOME/*
RUN ./bin/updateGTFSData.js

EXPOSE 16181
CMD ["node","siri_server.js"]
