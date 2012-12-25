# File

    # Fill a file with zeroes
    head -c <file size> /dev/zero > <file>

    # Use file as block device (maps /dev/loop0 as block device over <file>)
    losetup /dev/loop0 <file>

# Partitions

    # View partitions recognized by kernel
    cat /proc/partitions

    # Create new filesystem on block device
    mkfs.<filesystem>

    # Create swap

# fstab

    # Swap partition
    /dev/<partition>                                none    swap    defaults                    0 0

    # Mount logical volume as root (must have lvm2 module in initramfs)
    /dev/mapper/<volume_group>-<logical_volume>	    /       ext4    rw,relatime,data=ordered	0 1

    # Boot
    /dev/<partition>           	                    /boot   ext4    rw,relatime	                0 2

# RAID

    # TODO
    mdadm

# LUKS

    # Create volume on block device
    cryptsetup luksFormat

    # Map volume as block device (creates entry in /dev/mapper)
    cryptsetup luksOpen /dev/<encrypted block device> <decrypted name>

    # Unmap decrypted volume
    cryptsetup luksClose <decrypted name>

# LVM

    # Activate logical volumes and create /dev/<volume group>/<logical volume>
    lvchange -ay <volume group>   

    # Deactivate logical volumes and destroy /dev/<volume group>/<logical volume>
    lvchange -an <volume group>
