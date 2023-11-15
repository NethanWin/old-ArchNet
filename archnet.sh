timedatectl set-ntp true
# todo auto create partitions hard drives
lsblk
cfdisk /dev/vda
#temp fix ^

mkfs.ext4 /dev/vda1
mkfs.ext4 /dev/vda2

mount /dev/vda2 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot

pacstrap /mnt base base-devel linux linux-firmware vim

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash
pacman -S networkmanager grub

systemctl enable NetworkManager
grub-install /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg

passwd

#replace this with an auto command
vim /etc/locale.gen


locale-gen
echo "LANG=en-US.UTF-8" > /etc/locale.conf
echo "net" > /etc/hostname
ln -Sf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime

exit
unmount -R /mnt
reboot
