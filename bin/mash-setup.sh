#!/bin/bash

set -x
/usr/local/bin/entrypoint.sh

koji moshimoshi
yum install -y inotify-tools mash
cd /root/mash-git
git clone https://github.com/jpuhlman/koji-docker.git
cd koji-docker/
cp install-scripts/globals.sh \
   install-scripts/parameters.sh \
   install-scripts/deploy-mash.sh \
   install-scripts/mash.sh \
   install-scripts/gen-mash.sh \
   /usr/share/koji-docker/
sed -i  's/HOSTNAME/HOST/' /usr/share/koji-docker/parameters.sh

mkdir -p /etc/koji
cp install-scripts/globals.sh \
   install-scripts/parameters.sh \
   /etc/koji

chmod 755 /usr/share/koji-docker/*.sh
chmod 755 /etc/koji/*.sh
cp install-scripts/hostenv.sh /usr/sbin/
chmod 755 /usr/sbin/hostenv.sh

mkdir -p /etc/mash
chmod 777 /etc/mash

rm -f /etc/mash/mash.conf
/usr/share/koji-docker/deploy-mash.sh 





