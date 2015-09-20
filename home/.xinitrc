# Use modified dvorak keyboard layout with
#   * hold alt-gr to use extra lanugage characters/symbols
#   * both shifts toggle to and from QWERTY
setxkbmap   -layout "dvp,us"        \
            -variant ",altgr-intl"  \
            -option "lv3:ralt_switch_multikey,grp:shifts_toggle" #caps:escape"
# Make Caps-Lock and extra Control
[[ "" == `pgrep -x xmodmap` ]] && xmodmap $HOME/.Xmodmap

# Make cursor pointer instead of cross
xsetroot -cursor_name left_ptr

# Increase key repeat rates
xset r rate 200 30

# Synaptics daemon prevents touchpad for a moment after keyboard input
[[ "" == `pgrep -x syndaemon` ]] && syndaemon -t -k -i 1 -d &

# Screensaver daemon
[[ "" == `pgrep -x xscreensaver` ]] && xscreensaver -no-splash &

# Show mpd song change notifications
[[ "" == `pgrep mpcHook` ]] && $HOME/bin/mpcHook &

# Show mpd song change notifications
[[ "" == `pgrep -x mpd` ]] && mpd $HOME/Music/config &

# Launch emacs daemon if it's not running yet
[[ "" == `pgrep -f "emacs.*daemon"` ]] && emacs --daemon &

# Launch scim (Smart Common Input Method) daemon for foreign input
[[ "" == `pgrep scim` ]] && scim -d
