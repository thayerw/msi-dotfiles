#!/bin/sh
# Default acpi script that takes an entry for all actions

# NOTE: This is a 2.6-centric script.  If you use 2.4.x, you'll have to
#       modify it to not use /sys

minspeed=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq`
maxspeed=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
setspeed="/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"

set $*

case "$1" in
    button/power)
        #echo "PowerButton pressed!">/dev/tty5
        case "$2" in
            PWRF)   logger "PowerButton pressed: $2"
                    /sbin/poweroff
                    #echo "Power button pressed!">/dev/tty5
                    ;;
            *)      logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB)   
                    # screenlock X and go into standby (S3)
                    DISPLAY=:0 su -c - thayer "gnome-screensaver-command --lock"
                    /usr/sbin/pm-suspend

                    #echo -n mem >/sys/power/state 
                    #echo "Sleep button pressed!">/dev/tty5
            ;;
            *)      logger "ACPI action undefined: $2" ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            #AC)
            ADP1)
                case "$4" in
                    00000000)
                        echo -n $minspeed >$setspeed
                        /etc/rc.d/laptop-mode start
                    ;;
                    00000001)
                        echo -n $maxspeed >$setspeed
                        /etc/rc.d/laptop-mode stop
                    ;;
                esac
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)   #echo "offline" >/dev/tty5
                    ;;
                    00000001)   #echo "online"  >/dev/tty5
                    ;;
                esac
                ;;
            CPU0)   
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
                # check if the lid is open or closed, using the /proc file
                grep -q closed /proc/acpi/button/lid/*/state
                if [ $? = 0 ]; then
                    # screenlock X and go into standby (S3)
                    DISPLAY=:0 su -c - thayer "gnome-screensaver-command --lock"
                    /usr/sbin/pm-suspend
                    #echo -n mem >/sys/power/state
                fi

                #echo "LID switched!">/dev/tty5
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac
