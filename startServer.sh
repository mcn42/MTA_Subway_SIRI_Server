#!/bin/bash

cd /home/ubuntu/code/MTA_Subway_SIRI_Server
. ./import-tags.sh
<<<<<<< HEAD
node ./modifyJson.js
=======
. ./modifyJson.sh
>>>>>>> 4ad586f4c9d4679dc10dcd9c58a23147e92d1a1b
echo Server config: 
cat config/server.json
node ./siri_server.js
