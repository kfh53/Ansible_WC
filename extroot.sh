
# Update Dependencies
opkg update && opkg install block-mount kmod-fs-ext4 kmod-usb-storage kmod-usb-ohci kmod-usb-uhci e2fsprogs fdisk

# Configure FStab
DEVICE="$(sed -n -e "/\s\/overlay\s.*$/s///p" /etc/mtab)"
uci -q delete fstab.rwm
uci set fstab.rwm="mount"
uci set fstab.rwm.device="${DEVICE}"
uci set fstab.rwm.target="/rwm"
uci commit fstab

# Make FS
mkfs.ext4 /dev/sda1

# Copy over files to new partition
mount /dev/sda1 /mnt
cp -f -a /overlay/. /mnt
umount /mnt