## Build

1.  `cd install_files`
2.  `GOOS=linux GOARCH=arm GOARM=6 go build github.com/oandrew/ipod/cmd/ipod`
3.  compile the kernel modules (ipod-gadget directory) and put the .ko files in install_files
4.  copy the pipod directory to the Pi
5.  run `./install.sh`
6.  (configure bluetooth)[https://wiki.archlinux.org/index.php/bluetooth#My_computer_is_not_visible]: add `Class = 0x040408` to /etc/bluetooth/main.conf
7.  Install bt_speaker: https://github.com/lukasjapan/bt-speaker#partial-bluez5-port-of-bt-manager
8.  configure bt_speaker to use the ipod audio device: in `/etc/bt_speaker/config.ini` change play_command to `aplay -D plughw:CARD=iPodUSB,DEV=0 -f cd -`
