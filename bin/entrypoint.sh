#!/bin/bash
set -x

while true; do
    echo "Waiting for koji-hub to start..."
    hubstart=$(curl -X GET http://$HOST/)
	echo $hubstart
	if [ "x$hubstart" != "x" ]; then
		echo "koji-hub started:"
	    break
	fi
	sleep 5
done


mkdir /root/{.koji,bin}
cp $USER_CONFIG_DIR/config /root/.koji
cat /root/.koji/config
koji moshimoshi

/usr/sbin/sshd -D

