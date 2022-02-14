#!/bin/sh

start-stop-daemon --stop --name deluge-web

start-stop-daemon --stop --name deluged

protonvpn-cli disconnect
