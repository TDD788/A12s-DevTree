#!/bin/sh
if [ -f /system/bin/termux-sync.sh ]; then
   source /system/bin/termux-sync.sh
fi

if [ -f /sbin/from_fox_sd.sh ]; then
   source /sbin/from_fox_sd.sh
fi

is_screen_on() {
    brightness=$(cat /sys/class/backlight/*/brightness)
    [ "$brightness" -gt 0 ]
}

screentouchfix() {
    echo check_connection > /sys/class/sec/tsp/cmd && cat /sys/class/sec/tsp/cmd_result
}

previous_screen_state=1

monitor_events() {
    getevent | while read event2
    do
        if [[ "$event2" == *"/dev/input/event2: 0001 0074 00000000"* ]]; then
            if is_screen_on; then
                current_screen_state=0
            else
                current_screen_state=1
            fi

            if [ "$previous_screen_state" -eq 1 ] && [ "$current_screen_state" -eq 0 ]; then
                screentouchfix
            fi
            
            previous_screen_state=$current_screen_state
        fi
    done
}

if is_screen_on; then
    previous_screen_state=0
else
    previous_screen_state=1
fi

export TERM="pcansi"

monitor_events &
