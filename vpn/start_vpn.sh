#!/bin/sh

/usr/bin/protonvpn-cli ks --off

/sbin/start-stop-daemon --start --name protonvpn-cli --startas /usr/bin/protonvpn-cli -- connect US-WA#26

/usr/bin/protonvpn-cli ks --on

/sbin/start-stop-daemon --start --name deluged --startas /usr/bin/deluged

#https://forum.deluge-torrent.org/viewtopic.php?t=55673
#https://git.deluge-torrent.org/deluge/commit/?h=develop&id=d6c96d629183e8bab2167ef56457f994017e7c85
#had to apply above fix to get deluge-web to start without error
/sbin/start-stop-daemon --start --name deluge-web --startas /usr/bin/deluge-web
