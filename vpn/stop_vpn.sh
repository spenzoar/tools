#!/bin/sh

start-stop-daemon --stop --name deluge-web

start-stop-daemon --stop --name deluged

start-stop-daemon --stop --name protonvpn-cli disconnect
