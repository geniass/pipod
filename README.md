## Build

1.  `cd install_files`
2.  `GOOS=linux GOARCH=arm GOARM=6 go build github.com/oandrew/ipod/cmd/ipod`
3.  compile the kernel modules (ipod-gadget directory) and put the .ko files in install_files
4.  copy the pipod directory to the Pi
5.  run `./install.sh`
