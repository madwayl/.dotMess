paru -S mcontrolcenter msi-ec-dkms-git (dynamic kernel load module)
load module in debug mode
modprobe msi_ec debug=1

dkms status

Check module info if loaded
modinfo msi_ec | grep parm
lsmod | grep msi_ec
ls /sys/devices/platform/msi-ec/
/etc/modprobe.d
ls
echo "options msi_ec debug=1" | sudo tee /etc/modprobe.d/msi-ec.conf
sudo mkinitcpio -P
