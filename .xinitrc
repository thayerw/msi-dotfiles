# ~/.xinitrc
# Thayer Williams - http://cinderwick.ca

# local dbus session for pesky apps
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

xrdb -merge ~/.Xresources                   # load x resource prefs
xmodmap ~/.xmodmaprc                        # swap some keys around
xset +fp ~/.fonts                           # add local font path for x apps like dwm 
xset r rate 250 60                          # keyboard repeat delay and rate
xsetroot -solid darkgrey                    # set root window background
sh ~/.fehbg                                 # restore wallpaper, if any
autocutsel -fork                            # sync cutbuffer and XCLIPBOARD
unclutter &                                 # hide mouse cursor after 5s of idle
stalonetray -geometry 3x1+35-530 &          # system tray utility
keepassx &                                  # password manager
dropboxd &                                  # dropbox sync client
xautolock -time 10 -locker slock -nowlocker slock -detectsleep -corners 000+ -cornerdelay 3 & 
xterm -e bash -c 'screen -dRR -S $HOSTNAME' &
exec ck-launch-session ~/.dwm/startdwm
