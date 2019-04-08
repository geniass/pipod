#!/bin/bash
set -eu

# Install the kernel modules
cp install_files/ipod-gadget/*.ko /lib/modules/$(uname -r)/
# TODO: bring this back once DKMS is done
# modules='g_ipod_hid
# g_ipod_gadget
# g_ipod_audio
# '
# echo "$modules" >> /etc/modules

# Install the userspace component and service
cp install_files/ipod /usr/local/bin/
cp start-ipod.sh /usr/local/bin/
cp ipod.service /etc/systemd/system/
systemctl enable ipod


##
# Based on https://gist.github.com/oleq/24e09112b07464acbda1
##

# install bluetooth and pulseaudio dependencies
apt-get install alsa-utils bluez bluez-tools pulseaudio-module-bluetooth python-gobject python-gobject-2
usermod -a -G lp pi

# configure pulseaudio
# TODO: look at other resampling methods
# TODO: apparently in Pulseaudio 11 you can bypass resampling completely when the 2 sample rates are the same
pulseconfig='resample-method=speex-fixed-6
enable-remixing = no
enable-lfe-remixing = no
default-sample-format = s16le
default-sample-rate = 44100
default-sample-channels = 2
exit-idle-time = -1
'
echo "$pulseconfig" >> /etc/pulse/daemon.conf

mkdir -p /home/pi/.config/pulse
cp pulseaudio/default.pa /home/pi/.config/pulse/
mkdir -p /home/pi/.config/systemd/user
cp pulseaudio/pulseaudio.service /home/pi/.config/systemd/user/
chown -R pi:pi /home/pi/.config
sudo -u pi systemctl --user enable pulseaudio
loginctl enable-linger pi

# configure bluetooth
bluetoothaudioconfig='[General]
Class = 0x20041C
Enable = Source,Sink,Media,Socket'
echo "$bluetoothaudioconfig" > /etc/bluetooth/audio.conf

# setup a udev rule to automatically connect the bluetooth A2DP source to the Pulseaudio sink
cp udev/81-input-a2dp-autoconnect.rules /etc/udev/rules.d/