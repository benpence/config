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

    ip route show table local                                   # Show routes table that decides

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

# Rules
## Non-Persistent

    # Note: For commands below, the chains on default table 'filter' are used. Using
    # "-t mangle" or "-t nat" will apply changes to chains on those tables

    # List tables
    iptables -L                 \
        <chain>                 \ # (optional) if absent, show all chains
        --line-numbers          \ # (optional) show rule numbers
        -n                      \ # (optional) do not resolve IPs/ports to hostnames/services
        -v                        # (optional) show details (NOTE: This option will help distinguish
                                  # "ACCEPT all -- anywhere anywhere" for 1 interface vs all interfaces

    iptables -N <chain>           # Create new chain
    iptables -E <old> <new>       # Rename chain
    iptables -X                   # Delete chain, defaults to all non-default chains

    iptables -P <chain> <policy>  # Policy default (ACCEPT | DROP) for chain if no rules match
    iptables -A <chain> <rule>    # Append rule to end of chain
    iptables -I <chain>         \ # Insert rule
        <rule_number>           \ # (optional) position, defaults to 1
        <rule_options>
    iptables -R <chain>         \ # Replace rule
        <rule_number>           \ # position
        <rule_options>

    iptables -D <chain>         \ # Delete rule in chain
        <rule_number>           \ # position
    iptables -F                 \ # Flush chain (delete all rules)
        <chain>                   # (optional) chain, defaults to all chains

    # chains (lots of credit:  danielmiessler.com)
    #   PREROUTING  before routing decision
    #   INPUT       packets to be processed by local process
    #   OUTPUT      packets sent from local process
    #   FORWARD     routed packets not for local process
    #   POSTROUTING after routing, before handing them off to the hardware

    # tables (defaults)
    #   filter      allow/disallow packets
    #   nat         rewrite source, destination and track connections
    #   mangle      other packet modificatons

    #                          __INPUT___[local_process]__OUTPUT__
    #                         / (mangle)                 (mangle) \
    #                        /  (filter)                 (filter)  \
    # >-PREROUTING->-[route]-               (mangle)      (nat)     ->-POSTROUTING->
    #    (mangle)            \              (filter)               /    (mangle)
    #     (nat)               \_____________FORWARD_______________/      (nat)

    # Common rule options (man page)
    #   -i, --in-interface <name>
    #       interface | interface_prefix+
    #       for INPUT, FORWARD and PREROUTING chains only. prepend "!" to invert. append "+" for wildcard. defaults to all
    #   -o, --out-interface <name>
    #       interface | interface_prefix+
    #       for FORWARD, OUTPUT and POSTROUTING chains only. prepend "!" to invert. append "+" for wildcard. defaults to all
    #
    #   -s, --src, --source <address>
    #       network_name | ip_address(/optional_mask) | hostname
    #       prepend "!" to invert.
    #   -d, --dst, --destination <address>
    #       network_name | ip_address(/optional_mask) | hostname
    #       prepend "!" to invert.
    #
    #   -p, --protocol <protocol>
    #       tcp | udp | udplite | icmp | esp | ah | sctp | all | entry from /etc/protocols.
    #       prepend "!" to invert. defaults to all
    #
    #   --sport, --source-port  <ports>
    #       port | start_port:end_port
    #       range is inclusive. requires protocol tcp or udp
    #   --dport, --destination-port <ports>
    #       port | start_port:end_port
    #       range is inclusive. requires protocol tcp or udp
    #   --icmp-type <type>
    #       match specific ICMP type. requires protocol icmp
    #
    #   -m conntrack
    #       keeps track of connections and matches against their states
    #       --ctstate <state>,<state>
    #           NEW             new connection
    #           ESTABLISHED     already established
    #           INVALID         unidentifiable
    #           RELATED         related to connection already permitted
    #   -m limit
    #       match only a limited number of times per time period.
    #       --limit <frequency>
    #           number followed by "/second", "/minute", "/hour", or "/day". defaults to "3/hour"
    #   -m recent
    #        named lists of destination or source IPs (http://snowman.net/projects/ipt_recent)
    #       --name <list_name>
    #           defaults to "DEFAULT"
    #
    #       # Choose one
    #       --rsource
    #           focus on source IP (default)
    #       --rdest
    #           focus on destination IP
    #
    #       # Choose one
    #       --rcheck
    #           Check if IP is in list
    #           # Optional:
    #           --seconds <reset_at_most_seconds_ago>
    #           --hitcount <count>
    #       --update
    #           Check if IP is in list and reset time if it is
    #           # Optional:
    #           --seconds <reset_at_most_seconds_ago>
    #           --hitcount <count>
    #       --set
    #           adds IP to list with reset time
    #       --remove
    #           removes IP from list
    #
    #   -j, --jump <target>
    #       target is another chain
    #           jump to target chain. continue with next rule if target chain does not match
    #       target is built in target
    #           ACCEPT      allow packet. stop processing this chain
    #           REJECT      drop packet. respond with error packet. stop processing this chain
    #           DROP        drop packet. stop processing this chain
    #           LOG         log packet to syslog
    #               --log-prefix "<prefix>"
    #               --log-level <syslog_level>
    #           DNAT        (nat PREROUTING)  rewrite destination address
    #               --to <ip>
    #               --to <ip>:<port>
    #           SNAT        (nat POSTROUTING) rewrite source address. can maintain connection after temporary outage
    #               --to <ip>
    #               --to <ip>:<port>
    #           MASQUERADE  (nat POSTROUTING) rewrite source address as self. keeps track if interface address changes
    #       target is extension
    #

### Examples

    # Monitor iptables
    iptables -A INPUT -m limit --limit 10/minute -j LOG     # Log 10 packets/minute to dmesg if they don't match rules
    watch -n 0.5 iptables -nvL --line-numbers               # Live update of iptables rules matching packets

    # Allow all local traffic
    iptables -A INPUT  -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT

    # Allow hosts on 10.0.0.0/8 network to send ping request, host to send ping response to that request
    iptables -A INPUT  -p icmp --icmp-type 8 -s 10.0.0.0/8 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -p icmp --icmp-type 0 -d 10.0.0.0/8 -m conntrack --ctstate     ESTABLISHED,RELATED -j ACCEPT

    # Allow hosts NOT on 10.0.0.0/8 to initiate tcp connections on port 22 (ssh)
    iptables -A INPUT  -p tcp --dport 22 ! -s 10.0.0.0/8 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -p tcp --sport 22 ! -d 10.0.0.0/8 -m conntrack --ctstate     ESTABLISHED -j ACCEPT

    # Allow host to make http,https,dns requests and receive responses (ex. yum or apt-get)
    iptables -A INPUT             -p tcp --sport 80  -m conntrack --ctstate     ESTABLISHED -j ACCEPT
    iptables -A OUTPUT            -p tcp --dport 80  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    iptables -A INPUT             -p tcp --sport 443 -m conntrack --ctstate     ESTABLISHED -j ACCEPT
    iptables -A OUTPUT            -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    iptables -A INPUT  -s 8.8.8.8 -p udp --sport 53  -m conntrack --ctstate     ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -d 8.8.8.8 -p udp --dport 53  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT                                                                              -
    iptables -A INPUT  -s 8.8.8.8 -p tcp --sport 53  -m conntrack --ctstate     ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -d 8.8.8.8 -p tcp --dport 53  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT                                                                              -

    # nat (PAT actually) connections initiated from internal network
    iptables -t nat     -A POSTROUTING -i internal -o external            -j MASQUERADE
    iptables -t filter  -A FORWARD     -i internal -o external            -j ACCEPT
    iptables -t filter  -A FORWARD     -m conntrack --ctstate ESTABLISHED -j ACCEPT

    # Block for 5 minutes and log an IP every time they connect to anything other than ssh (tcp port 22)
    iptables -A FORWARD                                 -m recent --name portscan --update --seconds 300 -j DROP
        # ... some accept rules here
    iptables -A FORWARD -i external -p tcp --dport ! 22 --log-prefix "BLOCK_IP: "                        -j LOG
    iptables -A FORWARD -i external -p tcp --dport ! 22 -m recent --name portscan --set                  -j DROP

## Persistent

    # debian commands
    iptables -S      > /etc/iptables.rules      # save rules
    iptables-save    > /etc/iptables.downrules  # save rules

    # debian /etc/network/interfaces
    auto eth0
    iface eth0 inet dhcp
        post-up      iptables-restore < /etc/iptables.rules
        post-down   iptables-restore < /etc/iptables.downrules

    # redhat
    iptables save

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

# Kernel configuration
## Non-Persistent

    # Change ephemeral (dynamic) port range
    sysctl net.ipv4.ip_local_port_range = "<low_port> <high_port>"

    # Forward traffic not meant for this host
    systemctl net.ipv4.ip_forward = 1

    # Prevent bridged traffic from going through iptables
    sysctl net.bridge.bridge-nf-call-arptables = 0
    sysctl net.bridge.bridge-nf-call-ip6tables = 0
    sysctl net.bridge.bridge-nf-call-iptables  = 0

## Persistent

    # Strip off 'systemctl' from the command(s) above and put in /etc/sysctl.conf
