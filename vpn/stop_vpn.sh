#!/bin/sh

start-stop_daemon --stop --name deluged

protonvpn-cli disconnect
