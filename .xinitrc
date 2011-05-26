# ~/.xinitrc
# Thayer Williams - http://cinderwick.ca
# vim:ft=sh

# local dbus session for pesky GTK apps (brasero, nautilus gvfs)
if which dbus-launch >/dev/null 2>&1 && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval `dbus-launch --sh-syntax --exit-with-session`
fi

sh ~/.fehbg                                 # restore wallpaper, if any
xrdb -merge ~/.Xresources                   # load x resource prefs
xmodmap ~/.xmodmaprc                        # swap some keys around
xset +fp ~/.fonts                           # add local font path for x apps like dwm 
xset r rate 250 60                          # keyboard repeat delay and rate
xsetroot -cursor_name left_ptr              # sets root xcursor
xbindkeys                                   # custom hotkeys
xsetroot -solid darkgrey                    # set root window background
xautolock &                                 # prefs stored in Xresources
gnome-screensaver &                         # screensaver daemon, triggered with xautolock
parcellite &                                # clipboard manager
keepassx &                                  # password manager
dropboxd &                                  # dropbox sync client
(sleep 5 && stalonetray) &                  # systray util, delayed for dzen
urxvtcd -e bash -c 'screen -dRR -S $HOSTNAME' &
exec ck-launch-session ~/.dwm/startdwm
