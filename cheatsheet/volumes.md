# File

    # Fill a file with zeroes
    head -c <file size> /dev/zero > <file>

    # Use file as block device or filesystem
    losetup /dev/loop0 <file>                                   # block device
    mount -o loop <file> <mount_directory>                      # filesystem

    # Use parition embedded in file as block device or filesystem
    fdisk                                                       # View bytes per sector and partition starting sector

    losetup                                                 \   # Block device
        -o $((<sector> * <bytes_per_sector>))               \
        /dev/loop<integer>                                  \
         <file>             
    mount                                                   \   # Filesystem
        -o loop,offset=$((<sector> * <bytes_per_sector>))   \ 
         <file>                                             \
        <mount_directory>

    # Create iso file from directory
    mkisofs                                                 \
        -V <name>                                           \   # Name of disk
        -udf -J -Rr -r                                      \   # Include data necessary for various formats
        -allow-multidot -allow-leading-dots                 \
        -input-charset default                              \   # Character set for filenames
        -o <iso_file> <directory>

# Partitions

    cat /proc/partitions                                        # View partitions recognized by kernel

    mkfs.<filesystem_type> <block_device>                       # New filesystem on block device
    mkfs -t <filesystem_type> <block_device>                    # New filesystem on block device

    mkswap <block_device>                                       # New swap volume

# fstab

    # Swap partition
    /dev/<partition>                                none    swap    defaults                    0 0

    # Mount logical volume as root (must have lvm2 module in initramfs)
    /dev/mapper/<volume_group>-<logical_volume>	    /       ext4    rw,relatime,data=ordered	0 1

    # Boot
    /dev/<partition>           	                    /boot   ext4    rw,relatime	                0 2

# RAID

    # Erase superblock of device before use
    mdadm --zero-superblock /dev/<device>                       # Erase superblock
    sfdisk -d /dev/<source> | sfdisk /dev/<dest>                # Copy superblock from source to dest

    # Create new raid array /dev/<raid> of raid <type> using devices
    mdadm -C /dev/<raid>    \
        -l <type>           \                                   # raid level (0 1 4 5 6 10)
        -n <active>         \                                   # active devices in array
        -x <extra>          \                                   # extra (spare) devices in array
        /dev/<device>                                           # raid devices: space separated list of /dev devices
                                                                # use 'missing' as needed to create degraded array
    # Run, stop, remove array
    mdadm -R /dev/<raid>                                        # Run array
    mdadm -S /dev/<raid>                                        # Stop running array
    mdadm -r /dev/<raid>                                        # Remove stopped array

    # Scan details of arrays and add to config
    mdadm -D -s >> /etc/mdadm.conf                              # redhat
    mdadm -D -s >> /etc/mdadm/mdadm.conf                        # debian

    # Details on raid
    mdadm -D /dev/<raid>

    # Adding a device to the raid
    mdadm -a /dev/<raid> /dev/<device>

    # Removing a device from the raid array
    mdadm -f /dev/<raid> /dev/<device>                          # Fail a device manually in the array
    mdadm -r /dev/<raid> /dev/<device>                          # Remove a failed device from the array

    mdadm /dev/<raid> -f /dev/<device> -r /dev/<device>         # Manually fail and remove a device from array

# LUKS
    
    cryptsetup luksFormat <file/block_device>                   # Encrypt file (uses loopback) or block device 
    cryptsetup luksOpen <file/block_device> <name>              # Decrypt as /dev/mapper/<name>
    cryptsetup luksClose <decrypted_name>                       # Unmap decrypted volume

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
