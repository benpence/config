# LXC
## Command

    # Create lxc in /var/lib/lxc based on template
    # Note: The template scripts are in /usr/lib/lxc/templates.
            LXC caches vanilla install filesystems in /var/cache/lxc/
    lxc-create   -n <name> -t <template> -f <config>
    lxc-destroy  -n <name>

    # Start lxc
    lxc-start    -n <name> -d
    lxc-stop     -n <name>

    # Freeze all processes in lxc
    lxc-freeze   -n <name>
    lxc-unfreeze -n <name>

    # Monitor lxc
    lxc-console  -n <name>
    lxc-ps --lxc

## Example Config

    lxc.utsname         = <name>
    lxc.rootfs          = <block_device/directory>
    lxc.mount           = <fstab_file>

    lxc.network.type    = veth
    lxc.network.link    = br0                       # Host interface
    lxc.network.name    = eth0                      # VM interface
    lxc.network.hwaddr  = 11:22:33:44:55:66         # mac address
    lxc.network.flags   = up

    lxc.devttydir       = lxc                       # VM /dev directory for ttys
    lxc.tty             = 4                         # number of ttys
    lxc.pts             = 1024                      # VM does not share host /dev/pts
    lxc.arch            = amd64
    lxc.cap.drop        = sys_module mac_admin      # Limit VM capabilities
    lxc.pivotdir        = lxc_putold

# KVM

    virt-install                                \
        # Virt profile                          \
        --name          <name>                  \
        --description   <string>                \
        --connect       qemu:///system          \
        --virt-type     kvm                     \
        --vnc                                   \   # Make accessible to "virt-viewer"
                                                \
        # Virt type (choose one)                \
        --hvm                                   \   # Use full virtualization (implied for QEMU)
        --paravirt                              \   # (default) Use paravirtualization
                                                \
        # Hardware profile                      \
        --vcpus         <number>                \
        --cpuset        <numbers>               \   # Physical CPUs to use. Formats: 1-2 1,2 1-2,3
        --ram           <number>                \   # Megabytes
                                                \
        # OS                                    \
        --os-type       <type>                  \   # linux unix etc.
        --os-variant    <variant>               \   # ubuntuprecise freebsd8 etc.
                                                \
        # Install medium (choose one)           \
        --cdrom         <file/block_device>     \
        --location      nfs:<host>:<path>       \
        --location      nfs://<host>/<path>     \
        --location      http://<host>/<path>    \
        --location      ftp://<host>/<path>     \
                                                \
        # Install destination (choose one)      \
        --disk          <file/block_device>     \
                                                \
        # Network                               \
        --network       bridge=<bridge>         \
                                                \
        # Misc                                  \
        --extra-args "console=ttyS0"                # tty when installing Linux

# Xen
## Command

    # Show domains
    xl list                         

    # Create domain based on config (and attach console "-c")
    xl create   <config_file> -c      
    xl destroy  <domain>

    # Attach console to started domain
    xl console  <domain>             

    # Power signals
    xl shutdown <domain>
    xl reboot   <domain>

    # Suspend VM (memory still in use)
    xl pause    <domain>               
    xl unpause  <domain>             

    # Hibernate VM memory to file
    xl save     <domain> <state_file>
    xl restore  <state_file>

## Example Config

    # Assumes system installed into /dev/sdd5
    name        = "domain"

    kernel      = "/boot/vmlinuz"
    initrd      = "/boot/initrd.img"

    vcpus       = 1                                         # Virtual cpus
    cpus        = ["2", "3"]                                # Physical cpus
    memory      = 2048                                      # Megabytes

    vif         = [ 'mac=00:11:22:33:44:55, bridge=br0' ]   # Networking
    disk        = [ 'phy:sdd5,xvda1,w' ]                    # Virtualize /dev/sdd5 as writable /dev/xvda1 in VM
    root        = "/dev/xvda1"                              # Mount /dev/xvda1 as '/' in VM

    extra       = "xencons=tty"                             # Extra options passed on boot

# Libvirt
## Command

    virsh connect   <uri>           # qemu:///system qemu:///session lxc:// xen:/// etc
    virsh nodeinfo		            # Host info
    virsh capabilities	            #

    virsh list
    virsh dominfo   <domain>
    virsh dumpxl    <domain>	    # Dump xml config of guest

    virsh define    <xml_file>	    # Define new guest
    virsh start     <domain>	    # Start guest
    virsh create    <xml_file>      # Define and start new guest
    virsh undefine		            # Delete guest xml entry

    # Suspend (RAM still used by guest)
    virsh suspend   <domain>	
    virsh resume    <domain>

    # Hibernate (RAM saved to disk) 
    virsh save      <domain>
    virsh restore   <domain>

    # Power operations
    virsh shutdown  <domain>        # Send shutdown signal to guest
    virsh destroy   <domain>        # Immediately stop guest
    virsh reboot    <domain>        # Send reboot signal to guest

    # Read/write guest config options
    virsh vcpuinfo  <domain>
    virsh setvcpus  <domain> <count>	

    virsh setmem    <domain> <kilobytes>
    virsh setmaxmem <domain> <kilobytes>

    # Host virtual networking
    virsh net-list                  # List available virtual networks
    virsh net-dumpxml   <name>	    # Dump xml of virtual network

    virsh net-define    <xml_file>	# Create new virtual network
    virsh net-start     <name>		# Start virtual network
    virsh net-create    <xml_file>	# Create and start new virtual network

    virsh net-destroy   <name>	    # Stop virtual network
    virsh net-undefine  <name>      # Delete virtual network xml entry

## Example XML

    <!-- reference: http://libvirt.org/formatdomain.html -->
    <!-- TODO: Add more and check correctness -->
    
    <domain type="type">                    <!-- lxc | xen | kvm | qemu -->
        
        <name></name>                       <!-- domain -->
        <title></title>                     <!-- convenience title -->
        <description></description>         <!-- convenience description -->
        <memory unit='KiB'></memory>        <!-- memory -->

        <os>
            <type arch='x86_64'>exe</type>  
            <init>/sbin/init</init>
        </os>

        <vcpu cpuset="1-4,6">1</vcpu>       <!-- virtual cpus -->

        <!-- Power signals from virsh -->
        <on_poweroff>destroy</on_poweroff>
        <on_reboot>restart</on_reboot>
        <on_crash>destroy</on_crash>

        <devices>

            <emulator>/usr/lib/libvirt/libvirt_lxc</emulator>

            <!-- Block device mounted to VM path -->
            <filesystem type="block">
                <source dev='/host/path' /> 
                <target dir='/' />
            </filesystem>

            <!-- Network Bridge example -->
            <interface type="bridge">
                <source bridge='br0'/>
                <target dev='eth0'/>        
                <mac address='00:11:22:33:44:55'/>
            </interface>

            <console type="pty" />

        </devices>
    </domain>
