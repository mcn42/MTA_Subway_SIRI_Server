#! /usr/bin/env node

var filename = '/home/ubuntu/code/MTA_Subway_SIRI_Server/config/server.json';
var data = require(filename);

data.adminKey = process.env.SIRI_ADMIN_KEY;
data.activeFeed = process.env.SIRI_ACTIVE_FEED;
console.log(JSON.stringify(data));