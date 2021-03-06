#!/usr/bin/env node

// For more complex command-line arguments (file path or url)
// https://www.npmjs.com/package/minimist

'use strict';

var fs       = require('fs')   ,
    path     = require('path') ,
    //execFile = require('child_process').execFile ,
    fork = require('child_process').fork ,

    ConfigsService = require('../src/services/ConfigsService') ,
    gtfsConfig = ConfigsService.getGTFSConfig(), 

    scriptRelPath = '../node_modules/GTFS_Toolkit/bin/updateGTFSData.js' ,

    scriptAbsPath = path.join(__dirname, scriptRelPath),

    expectedArgMessage = 
        '\tThis script expects a single command-line argument that specifies where to retrieve\n' +
        '\tthe GTFS feed data. This argument should be either "file" or "url".\n' +
        '\tIf no argument is given, the default of "url" is used.\n' +
        '\tIf "file" is specified, the GTFS feed data must be in a zip file archive\n' +
        '\tat the path given in the GTFS config\'s feedDataZipFilePath property.\n' +
        '\tIf "url" is specified, the GTFS feed data will be retrieved from the url given\n' + 
        '\tin GTFS config\'s feedURL property, where, again, a zip archive is the required format.\n',

    source;


if (process.argv.length === 3) {
    source = process.argv[2].toLowerCase();

    if ( !((source === 'file') || (source === 'url')) ) {
       console.error("USAGE: An unrecognized GTFS feed source was given.\n" + expectedArgMessage);
       process.exit(1);
    }
} else {
    source = "url";
    console.log('INFO: Because the feed source ("file"|"url") was not specified, the default of "url" will be used.');
    console.log('\tThe GTFS data will be downloaded from ' + gtfsConfig.feedURL);
}

if (source === 'file') {
    console.log(gtfsConfig.feedDataZipFilePath);
    try {
        fs.accessSync(gtfsConfig.feedDataZipFilePath); 
    } catch (e) {
        console.error('Usage: if "file" is specified as the source from which to retrieve the GTFS feed data,\n' +
                      '\tthen the GTFS feed data must be in a zip file archive,\n' +
                      '\tat the path given in the GTFS config\'s feedDataZipFilePath property.\n' +
                      '\tWhen attempting to access a file at that location, the following error occurred:\n' +
                      e);
        process.exit(1);
    }
} else if ((source === 'url')  && (!gtfsConfig.feedURL)) {
    console.error('Usage: if "url" is specified, or used as the default, as the source from which\n' +
                  'to retrieve the GTFS feed data, then the feedURL property of the GTFS config object\n' +
                  'must be provided.');
    process.exit(1);
}


var childProcess = fork(scriptAbsPath, [gtfsConfig.gtfsConfigFilePath, source]);

//childProcess.on('message', function (m) { console.log(m); });

childProcess.on('exit', function (code) { 
    if (!code) {
        console.log('GTFS update complete.'); 
        process.exit(0) ;
    } else {
        console.error('GTFS update terminated with non-zero exit code.');
        process.exit(1) ;
    }
});
