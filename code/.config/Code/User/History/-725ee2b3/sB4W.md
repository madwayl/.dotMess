echo deep | sudo tee /sys/power/mem_sleep

findmnt -no UUID -T /swap/swapfile

# a1f047f5-d5d3-460d-a3e9-71e03b9d324f

sudo filefrag -v /swap/swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'

# 5057290

```bash
sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 \
--label "EFISTUB Arch" \
--loader /vmlinuz-linux \
--unicode 'root=a1f047f5-d5d3-460d-a3e9-71e03b9d324f rw resume=a1f047f5-d5d3-460d-a3e9-71e03b9d324f resume_offset=5057290 initrd=\initramfs-linux.img mem_sleep_default=deep' \
--verbose
```
