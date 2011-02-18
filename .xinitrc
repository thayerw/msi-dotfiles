# ~/.xinitrc
# Thayer Williams - http://cinderwick.ca

xrdb -merge ~/.Xresources                   # load x resource prefs
xmodmap ~/.xmodmaprc                        # swap some keys around
xset +fp ~/.fonts                           # add local font path for x apps like dwm 
xset r rate 250 60                          # keyboard repeat delay and rate
xsetroot -solid darkgrey                    # set root window background
sh ~/.fehbg                                 # restore wallpaper, if any
autocutsel -fork                            # sync cutbuffer and XCLIPBOARD
unclutter &                                 # hide mouse cursor after 5s of idle
stalonetray -geometry 2x1+35-530 &          # system tray utility
keepassx &                                  # password manager
dropboxd &                                  # dropbox sync client
xautolock -detectsleep &                    # screenlocker prefs are in xresources
urxvtcd -e bash -c 'screen -dRR -S $HOSTNAME' &
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session ~/.dwm/startdwm
