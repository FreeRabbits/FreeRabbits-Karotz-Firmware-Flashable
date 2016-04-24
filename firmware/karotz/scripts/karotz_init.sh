#!/bin/bash

if [ ! -d "/usr/www" ]; then
    logger -s "[INIT] Creating www root and cgi"
    mkdir -p /usr/www
    mkdir -p /usr/www/cgi-bin
    cp -f /karotz/scripts/www/index.html /usr/www/index.html
    cp -f /karotz/scripts/www/cgiinfo.sh /usr/www/cgi-bin/info
fi

if [ -f /usr/startup.sh ]; then
    logger -s "[INIT] Starting /usr/startup.sh"
    /usr/startup.sh
else
    logger -s "[INIT] No startup file found (/usr/startup.sh)"
fi

