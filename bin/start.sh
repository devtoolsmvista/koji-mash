#!/bin/bash

# script set in background
setsid /usr/local/bin/mash-setup.sh > output.txt &

# run systemd
exec /usr/sbin/init
