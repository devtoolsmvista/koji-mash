#!/bin/bash

set -x
koji moshimoshi
yum install -y inotify-tools
cd /root/mash-git
git clone https://github.com/jpuhlman/koji-docker.git
cd koji-docker/
cp  install-scripts/globals.sh \
    install-scripts/parameters.sh \
    install-scripts/deploy-mash.sh \
    install-scripts/mash.sh \
    install-scripts/gen-mash.sh \
    /usr/share/koji-docker/
chmod 755 /usr/share/koji-docker/*.sh
cp install-scripts/hostenv.sh /usr/sbin/
chmod 755 /usr/sbin/hostenv.sh

/usr/share/koji-docker/deploy-mash.sh 





