External Monitors loaded using the ddcci module - downloaded and loaded manually

$ git clone https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/
cd ddcci-driver-linux
make
sudo make install
sudo modprobe ddcci

ddcuti detect or i2cdetect to find the i2c device number

or using systemd service:
https://clinta.github.io/external-monitor-brightness/

udevd rule:

systemd service:
/etc/systemd/system/ddcci@.service

```
[Unit]
Description=ddcci handler
After=graphical.target
Before=shutdown.target
Conflicts=shutdown.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo Trying to attach ddcci to %i && success=0 && i=0 && id=$(echo %i | cut -d "-" -f 2) && while ((success < 1)) && ((i++ < 5)); do /usr/bin/ddcutil getvcp 10 -b $id && { success=1 && echo ddcci 0x37 > /sys/bus/i2c/devices/%i/new_device && echo "ddcci attached to %i"; } || sleep 5; done'
Restart=no
```

Issues with device/resource busy error

only runs after : sudo modprobe -r ddcci_backlight ddcci && sudo modprobe ddcci

Check with i2detect to check on monitor address status
t
