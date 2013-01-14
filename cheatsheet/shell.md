# ssh

## Tunneling

    # Tunnel traffic sent to <local_port> to <remote_peer>:<remote_port> via <remote_user>@<remote_host>
    ssh <remote_user>@<remote_host> -L <local_port>:<remote_peer>:<remote_port> -N  # -f to run in background

    # Tunnel traffic sent to <local_port> to <remote_host> and resolve destination based on application protocol
    ssh  <remote_user>@<remote_host> -D <local_port>
    
    # Reverse tunnel traffic sent to <remote_port> on <remote_host> to <local_peer>:<local_port> via localhost
    ssh <remote_user>@<remote_host> -R <remote_port>:<local_peer>:<local_port> -N   # -f to run in background


    # Example: Evade firewall rule by tunneling traffic sent to local port 3000 to talk.google.com:5222 via public_site
    ssh user@public_site -L 3000:talk.google.com:5222 home -N

    # Example: Use local port 8888 to proxy traffic through trusted_server
    ssh user@trusted_server -D 8888 -N

    # Example: ssh into home box from work through the work_server port 2222
    ssh user@work_server -R 2222:localhost:22 -N

    # Example: Let a public site access a local resource (that is internally accessible only) over port 7777
    ssh user@public_site -R 7777:local_resource:7777 -N

## .ssh/authorized_keys entries

    # Owner of <key> does not run shell, only <command>, when logging in
    command="<command>" <key>

    # Restrict which ssh features owner of <key> can make use of
    no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty <key>

    # Example: Route incoming ssh requests for this key to internal_peer (assuming established keys with internal_peer)
    command="ssh user@internal_peer" ssh-rsa blahblahblahblahblah...

## One off commands

    # Piping the microphone from one machine to the speakers of another
    dd if=/dev/dsp | ssh <user>@<host> dd of=/dev/dsp

# netcat

    # Use fifo file and netcat to make a quick remote shell on <port>
    mkfifo pipe && cat pipe | nc -l localhost <port> | bash > pipe
