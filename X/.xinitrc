# Make cursor pointer instead of cross
xsetroot -cursor_name left_ptr

# Synaptics daemon prevents touchpad for a moment after keyboard input
syndaemon -t -k -i 1 -d &

# Screensaver daemon
xscreensaver -no-splash &

# Launch urxvt if it's not running yet
[[ "" == `pgrep -x urxvt` ]] && urxvt &
