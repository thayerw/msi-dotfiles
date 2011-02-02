# ~/.xinitrc
# Thayer Williams - http://cinderwick.ca

# local dbus session for pesky apps
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

xrdb -merge .Xresources
xmodmap ~/.xmodmaprc                        # swap some keys around
xset +fp ~/.fonts                           # add local font path for x apps like dwm 
xset r rate 250 60                          # keyboard repeat delay and rate
xsetroot -cursor_name left_ptr -bg '#666' -fg '#222' -mod 2 2     # set root cursor and background
sh ~/.fehbg                                 # restore wallpaper
unclutter -noevents &                       # hide mouse cursor on idle
stalonetray &                               # system tray utility 
keepassx &                                  # password manager
glipper-old &                               # clipboard...do i really need this?
xautolock -time 10 -locker slock -nowlocker slock -detectsleep -corners 000+ -cornerdelay 3 & 
xterm -e bash -c 'screen -dRR -S $HOSTNAME' &
dropboxd &
exec ck-launch-session ~/.dwm/startdwm
