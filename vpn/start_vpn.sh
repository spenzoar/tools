#!/bin/sh

protonvpn-cli connect US-IL#15

start-stop-daemon --start --name deluged --startas /usr/bin/deluged

#https://forum.deluge-torrent.org/viewtopic.php?t=55673
#https://git.deluge-torrent.org/deluge/commit/?h=develop&id=d6c96d629183e8bab2167ef56457f994017e7c85
#had to apply above fix to get deluge-web to start without error
start-stop-daemon --start --name deluge-web --startas /usr/bin/deluge-web
