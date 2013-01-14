# Processes

    # Show all processes hierarchially (H) with entire command line invocation (ww)
    ps auxww -H

    # List program names and PIDs (l) whose command line invocation contain <string> (f)
    pgrep -fl <string>

    # System calls and signals for <PID> and spawned children (f)
    strace -f -p <PID>

    # Open files for <PID>
    lsof -p <PID>

## ps sorting

    # Sort ascending (+) or descending (-) by <KEY>, where <KEY> is one from table below
    ps --sort=[+|-]<KEY>

    # short long        description
    # c     cmd         simple name of executable
    # C     pcpu        cpu utilization
    # f     flags       flags as in long format F field
    # g     pgrp        process group ID
    # G     tpgid       controlling tty process group ID
    # j     cutime      cumulative user time
    # J     cstime      cumulative system time
    # k     utime       user time
    # m     min_flt     number of minor page faults
    # M     maj_flt     number of major page faults
    # n     cmin_flt    cumulative minor page faults
    # N     cmaj_flt    cumulative major page faults
    # o     session     session ID
    # p     pid         process ID
    # P     ppid        parent process ID
    # r     rss         resident set size
    # R     resident    resident pages
    # s     size        memory size in kilobytes
    # S     share       amount of shared pages
    # t     tty         the device number of the controlling tty
    # T     start_time  time process was started
    # U     uid         user ID number
    # u     user        user name
    # v     vsize       total VM size in KiB
    # y     priority    kernel scheduling priority

    # Example: Get 3 most CPU-bound processes
    ps aux --sort=-pcpu | head -4

# Memory

    # Print free memory and swap
    free

    # Print virtual memory usage every <count seconds. First line is average since boot
    vmstat <count>

    # List processes sorted in descending order by memory-usage
    ps aux --sort=-resident

    # Find Out Of Memory errors in /var/log/{messages,kern.log,syslog}{,.0}
    for log in messages kern.log syslog; do egrep -i "s[ie]g|oo(m|ps)" /var/log/$log{,.0}; done

    # Do not kill <PID> on Out Of Memory
    echo -17 > /proc/<PID>/oom_adj

# systemd

## Services

    # List all targets for systemctl
    systemctl list-unit-files

    # Enable or disable <TARGET> at boot
    systemctl [enable|disable] <TARGET>

    # Change current status of <TARGET>
    systemctl [start|stop|reload|restart] <TARGET>

    # Change state of system
    systemctl [poweroff|reboot|suspend|hibernate]

## Logging

    # View live messages
    journalctl -f

    # Messages of <PATH_TO_EXECUTABLE>
    journalctl <PATH_TO_EXECUTABLE>

    # Messages of <PID>
    journalctl _PID=<PID>

    # Messages of <UNIT>, where <UNIT> is one from `systemctl list-unit-files`
    journalctl -u <UNIT>
