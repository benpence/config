# Make cursor pointer instead of cross
xsetroot -cursor_name left_ptr

# Synaptics daemon prevents touchpad for a moment after keyboard input
[[ "" == `pgrep -x syndaemon` ]] && syndaemon -t -k -i 1 -d &

# Use modified dvorak keyboard layout with
#   * hold alt-gr to use extra lanugage characters/symbols
#   * both shifts toggle to and from QWERTY
#   * <escape> and <capslock> are switched
setxkbmap   -layout "dvp,us"        \
            -variant ",altgr-intl"  \
            -option "lv3:ralt_switch_multikey,grp:shifts_toggle,caps:swapescape"

# Screensaver daemon
[[ "" == `pgrep -x xscreensaver` ]] && xscreensaver -no-splash &

# Show mpd song change notifications
[[ "" == `pgrep mpdHook` ]] && $HOME/bin/mpcHook &

# Launch urxvt if it's not running yet
[[ "" == `pgrep -x urxvt` ]] && urxvt &
