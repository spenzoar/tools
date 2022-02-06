#!/bin/sh

echo $1

./bitcoin-22.0/bin/bitcoin-cli -rpcconnect=192.168.2.108 -rpcport=8332 -rpcuser=bitcoin -rpcpassword=1234 getblockcount
