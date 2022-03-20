#!/bin/sh

#first test writing to a file to see if this script is actually running
date > /home/bitcoinadmin/_git/spenzoar/tools/bitcoin/start_test.txt


/sbin/start-stop-daemon --start --name bitcoind --startas /home/bitcoinadmin/_git/spenzoar/tools/bitcoin/bitcoin-22.0/bin/bitcoind -- -daemon --datadir=/media/sf_TheFutureIsNow/BitcoinData



