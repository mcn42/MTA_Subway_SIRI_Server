var fs = require('fs');
var filename = './config/server.json';

var data = require(filename);
var adminKey = process.env.SIRI_ADMIN_KEY;
if(adminKey !== null)
  data.adminKey = adminKey;
var activeFeed = process.env.SIRI_ACTIVE_FEED;
if(activeFeed !== null)
  data.activeFeed = activeFeed;

var json = JSON.stringify(data); 
console.log(json);
fs.writeFile(filename, json); 

