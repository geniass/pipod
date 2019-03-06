# PiPod

A bunch of scripts and configs that allows streaming audio via bluetooth to a [fake ipod device](https://github.com/oandrew/ipod).

Useful if your car only supports Apple devices for some reason (why Fiat and Alfa, why).

Tested on:
*  Raspberry Pi Zero W (Raspbian Stretch Lite 2018-11-13)

## Assumptions
*  You have a device (e.g. a car) that supports playing music from an iPhone/iPod etc. over USB. You want to play music from something else (e.g. an Android phone) over bluetooth.
*  OS: Raspbian Stretch Lite

## Build and Install

1.  `cd install_files`
2.  `GOOS=linux GOARCH=arm GOARM=6 go build github.com/oandrew/ipod/cmd/ipod`
3.  add `dtoverlay=dwc2` to the end of /boot/config.txt to enable USB gadget mode
4.  compile the kernel modules (ipod-gadget directory) and put the .ko files in install_files
5.  copy the pipod directory to the Pi
6.  run `sudo ./install.sh`
7.  add `pulseaudio --start` to ~/.bashrc
8.  [enable auto login](https://gist.github.com/oleq/24e09112b07464acbda1#autologin) so that Pulseaudio can start automatically
9.  edit the file `a2dp-autoconnect`.
Replace the `NAME` variable with your bluetooth device's MAC address.
Also make sure that if you run `pactl list sources short`, the value of `$PA_SINK` shows up in the output.
10.  [Pair and trust](https://gist.github.com/oleq/24e09112b07464acbda1#setup-bluetooth) your bluetooth device
11.  Reboot, connect everything (USB to car; manually connect phone via bluetooth) and test!


## TODO:
*  Figure out how to get the Pi to automatically connect to the bluetooth device (currently you have to manually connect from the device)
*  Use DKMS to auto-build and install kernel modules
*  Investigate Pulseaudio 11 which can maybe bypass resampling