#!/bin/bash

exec ./docker_start.sh

echo $SIRI_SERVER_CONFIG > config/server.json
