Install for creating `grub.cfg`:

```sh
grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/boot --bootlader-id=arch
```

Simply update with

```sh
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

If any make edits to `/etc/default/grub` and update grub again.
