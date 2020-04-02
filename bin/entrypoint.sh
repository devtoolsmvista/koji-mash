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
mkdir /config/kojiadmin/.koji
cp $USER_CONFIG_DIR/config /config/kojiadmin/.koji
cat /root/.koji/config
cp $USER_CONFIG_DIR/*.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust extract

koji moshimoshi

/usr/sbin/sshd -D

