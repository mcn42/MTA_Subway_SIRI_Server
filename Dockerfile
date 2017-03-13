FROM node:argon
MAINTAINER Michael Nilsen

RUN set -e
RUN apt-get update && apt-get -y upgrade

RUN useradd --user-group --create-home --shell /bin/false app
ENV HOME=/home/app

RUN npm install -g npm
RUN npm install -g n forever
RUN n lts

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
