timedatectl set-ntp true
# manual partitioning
# lsblk
parted /dev/vda mklabel msdos 
parted /dev/vda mkpart primary ext4 1MiB 513MiB
parted /dev/vda set 1 boot on
parted /dev/vda mkpart primary ext4 513MiB 100%

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

#part 2-------------------------------------
echo "choose a root password:"
passwd

sed -i -e '/^#en_US\.UTF-8 UTF-8/s/^#//' -e '/^#en_US ISO-8859-1/s/^#//' /etc/locale.gen

locale-gen
echo "LANG=en-US.UTF-8" > /etc/locale.conf
echo "net" > /etc/hostname
ln -Sf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime

exit
unmount -R /mnt
reboot

# after base install
useradd -m name
# vim /etc/sudoers
# uncomment group ALL=(ALL:ALL)ALL
# write "Deafaults !tty_tickets

pacman -S xorg-server xorg-xinit
pacman -S xorg
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter
sudo systemctl enable lightdm.service
