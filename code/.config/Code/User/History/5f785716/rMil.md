paru -S mcontrolcenter msi-ec-dkms-git
load module in debug mode
modprobe msi_ec debug=1

dkms status

modinfo msi_ec | grep parm\n
lsmod | grep msi_ec\n
ls /sys/devices/platform/msi-ec/
/etc/modprobe.d
ls
echo "options msi_ec debug=1" | sudo tee /etc/modprobe.d/msi-ec.conf\n
sudo mkinitcpio -P\n
