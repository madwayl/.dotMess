sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 \
--label "EFISTUB Arch" \
--loader /vmlinuz-linux \
--unicode 'root=a1f047f5-d5d3-460d-a3e9-71e03b9d324f rw resume=a1f047f5-d5d3-460d-a3e9-71e03b9d324f resume_offset=5057290 initrd=\initramfs-linux.img mem_sleep_default=deep' \
--verbose