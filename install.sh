#!/bin/bash
set -eu

cp install_files/ipod-gadget/*.ko /lib/modules/$(uname -r)/
cp install_files/ipod /usr/local/bin/
cp start-ipod.sh /usr/local/bin/
cp ipod.service /etc/systemd/system/

systemctl enable ipod
