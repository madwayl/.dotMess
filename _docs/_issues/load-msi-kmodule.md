Needed msi-ec-dkms-git (dynamic kernel load module - now supports MSI Modern 15H AI C1MG)

```sh
sudo modprobe msi_ec 
sudo modprobe ec_sys write_support=1
```

Final Check: `dkms status`

Check module info if loaded

```sh
modinfo msi_ec | grep parm
lsmod | grep msi_ec
ls /sys/devices/platform/msi-ec/
/etc/modprobe.d
ls
echo "options msi_ec debug=1" | sudo tee /etc/modprobe.d/msi-ec.conf
sudo mkinitcpio -P
```

also needs sys-ec (for fan control)
Solved with:
1. https://github.com/Alien777/fedora_sys_ec

or simply https://github.com/BeardOverflow/msi-ec is enough
