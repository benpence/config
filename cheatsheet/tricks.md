# dd

    # Use fifo file and netcat to make a quick remote shell on <port>
    mkfifo pipe && cat pipe | nc -l localhost <port> | bash > pipe

    # Force dd to show its status
    killall -USR1 dd

# screen

    # X11 Forwarding
    echo $DISPLAY       # Run before screen. Output is of format "host:N.0"
    export DISPLAY=:N.0 # Run in screen, with N from previous output

# Printer

    # Print to network printer from command line (
    cat <file> | sed -e 's/$/\r/' | netcat <printer_ip> 9100
    cat <pdf>  | pdf2ps - -       | netcat <printer_ip> 9100
