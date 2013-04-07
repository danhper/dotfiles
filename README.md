# ArchLinux Installation
## mkinitcpio

Install dmraid

    pacman -S dmraid

Add hooks

Add `mdadm_udev` and `dmraid` to `/etc/mkinitcpio.conf` hooks.

    ....
    HOOKS = "hook1 hook2 mdadm_udev dmraid"
    .....

Generate kernel image

    mkinitcpio linux

## Install bootloader

After chroot and linux image generation

    pacman -S grub-bios
    grub-install /dev/md126
    grub-mkconfig -o /boot/grub/grub.cfg


## Install video drivers and touchpad drivers

    pacman -S xf86-video-intel
    pacman -S xf86-input-synaptics

