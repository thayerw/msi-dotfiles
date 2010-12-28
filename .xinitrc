#
# ~/.xinitrc
# Thayer Williams - http://cinderwick.ca
#

# local dbus session for pesky apps
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

# setup dual-head
X=`xrandr | awk '/VGA/ {print $2}'`
if [ "$X" = "connected" ]; then
    #xrandr --output VGA --left-of LVDS
    #xrandr --output VGA1 --below LVDS1 --mode 1280x1024
    xrandr --output LVDS1 --off --output VGA1 --mode 1280x1024 --pos 0x0 --rotate normal
    numlockx
fi

#xrandr --output LVDS1 --gamma 1:1:1.1       # LED backlight is a bit too blue
xrdb -merge .Xresources
xmodmap -e "keycode 113 = Super_L"          # reassign Alt_R to Super_L
xmodmap -e "remove mod1 = Super_L"          # make sure X keeps it out of the mod1 group
xmodmap ~/.xmodmaprc                        # set caps lock to ctrl
xset r rate 250 60                          # keyboard repeat delay and rate
xsetroot -cursor_name left_ptr -solid '#222'     # set root cursor and background
#nitrogen --restore
unclutter -noevents &
#trayer --edge top --align right --distance 0 --widthtype request --height 18 --transparent true --alpha 0 --tint 0xeeeeee --SetDockType true &
trayer --edge top --align left --distance 32 --margin 10 --widthtype request --width 16 --expand true --transparent true --alpha 255 --tint 0x333333 &
keepassx &
glipper-old &
xautolock -time 10 -locker slock -nowlocker slock -detectsleep -corners 000+ -cornerdelay 3 & 
urxvtcd -e bash -c "tmux attach -t dublin" &
dropboxd &
#gnome-terminal -x bash -c "tmux attach -d -t dublin" &
exec ck-launch-session startdwm

