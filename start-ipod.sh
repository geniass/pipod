#!/bin/bash
set -eu

depmod -a
modprobe -r g_ipod_gadget
modprobe -r g_ipod_hid
modprobe -r g_ipod_audio
modprobe g_ipod_audio
modprobe g_ipod_hid
modprobe g_ipod_gadget

systemctl start ipod

exec ipod -d serve /dev/iap0
