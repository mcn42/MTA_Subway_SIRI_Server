#!/bin/bash

#if ! [[ -z "${BUILD}" ]]; then
#    echo "Skipping Build server.json substitution"
#    exit 0
#fi

if [[ -z "${SERVER_PORT}" ]]; then
    sed -i "s/<PORT>/16181/g" config/server.json
else
    sed -i "s/<PORT>/$SERVER_PORT/g" config/server.json
fi

if [[ -z "${ACTIVE_FEED}" ]]; then
    sed -i "s/<FEED>/mta_subway/g" config/server.json
else
    sed -i "s/<FEED>/$ACTIVE_FEED/g" config/server.json
fi

if [[ -z "${ADMIN_PWD}" ]]; then
    export ADMIN_PWD=$(pwgen 12)
    sed -i "s/<PWD>/$ADMIN_PWD/g" config/server.json
    echo "******************************************"
    echo "***  ADMIN PASSWORD SET TO $ADMIN_PWD  ***"
    echo "******************************************"
else
    sed -i "s/<PWD>/$ADMIN_PWD/g" config/server.json
fi

cat config/server.json
