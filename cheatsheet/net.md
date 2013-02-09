# Interfaces
## Non-Persistent

    ip link                         # show interfaces
    ip link set up <interface>      # put interace up
    ip link set down <interface>    # put interface down

    ifconfig                        # show interfaces
    ifconfig <interface> up         # put interace up
    ifconfig <interface> down       # put interface down

## Persistent

    # debian /etc/network/interfaces
    auto <interface>

    # redhat /etc/sysconfig/network-scripts/ifcfg-<interface>
    DEVICE=<interface>
    ONBOOT=yes

# Addresses
## Non-Persistent

    # Note: Addresses for ip command in CIDR notation (ex. 192.168.1.5/24)
    # Note: Interfaces can have multiple (unique) addresses
    ip addr                                             # show interface addresses
    ip addr addr add <address> dev <interface>          # add address to interface
    ip addr addr del <address> dev <interface>          # delete address from interface

    ifconfig                                            # show interface addresses
    ifconfig <interface> <address> netmask <netmask>    # add address to interface

## Persistent

    # debian /etc/network/interfaces
    iface <interface> inet <static/dhcp>
        # Assuming static:
        address <address>
        netmask <netmask>
        gateway <address>

    # redhat /etc/sysconfig/network-scripts/ifcfg-<interface>
    DEVICE=<interface>
    NETWORK=<network>
    IPADDR=<address>
    NETMASK=<netmask>
    BOOTPROTO=<none/dhcp/bootp> # dynamic protocol for getting address
    USERCTL=<yes/no>            # can non-root users control interface

# ARP

    ip neigh                                                    # Show ARP entries
    ip neigh add <address> lladdr <mac_address> dev <interface> # Add ARP entry
    ip neigh del <address> dev <interface>                      # Delete ARP entry
    ip link set dev <interface> arp off                         # Disable ARP on interface

    arp                                                         # Show ARP entries
    arp -s <address> <mac_address> -i <interface>               # Add ARP entry
    arp -d <address>                                            # Delete ARP entry
    ifconfig -arp <interface>                                   # Disable ARP on interface
                                                                
# Routes
## Non-Persisent

    netstat -rn                                                 # show kernel routing table

    # Note: Addresses in CIDR notation (ex. 192.168.1.5/24)
    ip route                                                    # show routes
    ip route add <address/network> dev <interface>              # route traffic to address/network through interface
    ip route add default via <address>                          # forward traffic matching no routes to address
    ip route del <address/network>                              # delete route

    route                                                       # show routes
    route add -host <address> netmask <netmask> dev <interface> # route traffic to address through interface
    route add -net  <address> netmask <netmask> dev <interface> # route traffic to network through interface
    route add default gw <address>                              # forward traffic matching no routes to address
    route del <route>                                           # delete route (exactly as added above)

## Persistent

    # debian /etc/network/interfaces
    iface <interface> inet <method>
        up <command>    # Use above commands for adding route on interface up
        down <command>  # Use above commands for deleting route on interface down

    # redhat /etc/sysconfig/network-scripts/route-<interface>
    GATEWAY0=<address>        
    NETMASK0=<netmask>        
    ADDRESS0=<address/network>

    GATEWAY1=<address>
    # etc

# Bridges
## Non-Persistent

    brctl show                                  # Show bridges

    brctl addbr <bridge_interface>              # Add bridge
    brctl stp <bridge_interface> <on/off>       # spanning tree protocol (off ONLY if no loops in network)
    brctl delbr <bridge_interface>              # Delete bridge

    brctl addif <bridge_interface> <interface>  # Add interface to bridge
    brctl delif <bridge_interface> <interface>  # Delete interface from bridge

## Persistent

    # debian /etc/network/interfaces
    auto <bridge_interface>
    iface <bridge_interface> inet static
        bridge_ports <interface>
        bridge_stp on
        # etc

    # redhat /etc/sysconfig/network-scripts/ifcfg-<bridge_interface>
    DEVICE=<bridge_interface>
    TYPE=Bridge

    # redhat /etc/sysconfig/network-scripts/ifcfg-<interface>
    DEVICE=<interface>
    BRIDGE=<bridge_interface>
