#!/bin/sh

protonvpn-cli connect US-IL#15

start-stop-daemon --start --name deluged --startas /usr/bin/deluged

start-stop-daemon --start --name deluge-web --startas /usr/bin/deluged-web
