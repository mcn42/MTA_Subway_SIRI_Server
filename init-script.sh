set -e 

sudo apt-get update
sudo apt-get -y upgrade 
sudo apt-get install -y npm git

sudo npm install -g n forever
sudo n lts
sudo npm install -g npm

sudo npm install --production
sudo ./import-tags.sh
echo Reading GTFS Static data from $SIRI_STATIC_DATA_URL
sudo ./bin/updateGTFSData.js url $SIRI_STATIC_DATA_URL
