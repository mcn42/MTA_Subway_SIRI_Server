#!/bin/bash

cd /home/ubuntu/code/MTA_Subway_SIRI_Server
. ./import-tags.sh
. ./modifyJson.sh
echo Server config: 
cat config/server.json
node ./siri_server.js
