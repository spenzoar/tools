#!/bin/sh

/sbin/start-stop-daemon --stop --name deluge-web

/sbin/start-stop-daemon --stop --name deluged

/sbin/start-stop-daemon --stop --name protonvpn-cli disconnect

protonvpn-cli ks --off
