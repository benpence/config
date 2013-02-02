# File

    # Fill a file with zeroes
    head -c <file size> /dev/zero > <file>

    # Use file as block device or filesystem
    losetup /dev/loop0 <file>                               # Block device
    mount -o loop <file> <mount_directory>                  # Filesystem

    # Use parition embedded in file as block device or filesystem
    fdisk                                                   # View bytes per sector and partition starting sector

    losetup \                                               # Block device
        -o $((<sector> * <bytes_per_sector>)) \
        /dev/loop<integer> \
         <file>             
    mount \                                                 # Filesystem
        -o loop,offset=$((<sector> * <bytes_per_sector>)) \ 
         <file> \
        <mount_directory>    

# Partitions

    cat /proc/partitions                        # View partitions recognized by kernel

    mkfs.<filesystem_type> <block_device>       # New filesystem on block device
    mkfs -t <filesystem_type> <block_device>    # New filesystem on block device

    mkswap <block_device>                       # New swap volume

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
    
    cryptsetup luksFormat <file/block_device>       # Encrypt file (uses loopback) or block device 
    cryptsetup luksOpen <file/block_device> <name>  # Decrypt as /dev/mapper/<name>
    cryptsetup luksClose <decrypted name>           # Unmap decrypted volume

# LVM

    # Activate logical volumes and create /dev/<volume group>/<logical volume>
    lvchange -ay <volume group>   

    # Deactivate logical volumes and destroy /dev/<volume group>/<logical volume>
    lvchange -an <volume group>

    # Shrink a logical volume containing a filesystem
    e2fsck -f /dev/<volume group>/<logical volume>              # Check filesystem (for resize2fs)
    resize2fs /dev/<volume group>/<logical volume> <size>       # Shrink filesystem

    lvresize  /dev/<volume group>/<logical volume> -L <size>    # Shrink volume
    
    volume=/dev/<volume group>/<logical volume>                 # Add extents to volume until big enough
    while { e2fsck -y $volume > /dev/null; [ $? -ne 0 ]; }; do  # for filesystem (increase extents number
            lvextend -l +1 $volume;                             # as desired)
    done;
