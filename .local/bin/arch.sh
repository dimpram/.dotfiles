#!/bin/sh

# THIS SCRIPT IS STILL A WORK IN PROGRESS SO PLEASE DONT USE IT UNLESS YOU KNOW
# WHAT YOU ARE DOING

# Assuming you are connected to ethernet

# Set the keyboard layout
loadkeys us

# Check internet
ping google.com

# Update the system clock
timedatectl set-ntp true

# partition disks
# 1st partition -> EFI ~ 300M
# 2nd partition -> SWAP ~ 2G
# 3rd partition -> Linux filesystem ~ remaining space

# Format partitions
mkfs.fat -F32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

# Mount file systems
mount /dev/nvme0n1p3 /mnt
swapon /dev/nvme0n1p2

# Install essential packages
pacstrap /mnt base linux linux-firmware vim man-db man-pages texinfo

# Fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt

# Set timezone
ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localtime
hwclock --systohc

# Localization
echo -e "el_GR.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo -e "LANG=en_US.UTF-8" > /etc/locale.conf
echo -e "KEYMAP=us" > /etc/vconsole.conf

# Network configuration
echo -e "neptune" > /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tneptune.localdomain\tneptune" > /etc/hosts

# Initramfs
# Creating a new initramfs is usually not required, because mkinitcpio
# was run on installation of the kernel package with pacstrap.

# Root password
echo "Add a new root password"
passwd

# Adding sudo
pacman -S --no-confirm sudo

# Creating a user
useradd -m -G  wheel,audio,video,optical,storage,lp naut 
echo "Set a new user password"
passwd naut

# Configuring sudo
visudo

# Adding grub
pacman -S --no-confirm grub efibootmgr

# Configuring grub
mkdir /boot/efi
mount /dev/nvme0n1p1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# Installing additional packages
pacman -S networkmanager reflector git intel-ucode

# Configuring intel microcode
grub-mkconfig -o /boot/grub/grub.cfg

# Configuring reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo -e "--save /etc/pacman.d/mirrorlist\n--country Greece,France,Germany\n--protocol https\n--latest 10" > /etc/xdg/reflector/reflector.conf

# Enabling services
systemctl enable NetworkManager.service
systemctl enable reflector.service

# Exiting installation
exit
unmount -R /mnt # or use unmount -l /mnt
reboot          # You probably need to remove the flash drive
