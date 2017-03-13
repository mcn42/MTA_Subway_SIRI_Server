#! /usr/bin/env node
var data = require('/home/ubuntu/code/MTA_Subway_SIRI_Server/config/server.json');
data.adminKey = process.env.SIRI_ADMIN_KEY;
data.activeFeed = process.env.SIRI_ACTIVE_FEED;
console.log(JSON.stringify(data));