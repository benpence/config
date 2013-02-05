# netcat

    # Use fifo file and netcat to make a quick remote shell on <port>
    mkfifo pipe && cat pipe | nc -l localhost <port> | bash > pipe
