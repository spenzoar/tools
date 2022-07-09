#!/bin/sh

#default to help command if none given
cmd="help"
if [ -z $1 ]
then
	echo $cmd 
else
	cmd=$1
fi

./bitcoin-22.0/bin/bitcoin-cli -rpcconnect=192.168.2.120 -rpcport=8332 -rpcuser=bitcoin -rpcpassword=1234 $cmd 
