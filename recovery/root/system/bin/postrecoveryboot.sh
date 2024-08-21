#!/system/bin/sh

if [ -f /sbin/from_fox_sd.sh ]; then
   source /sbin/from_fox_sd.sh
fi

screentouchfix() {
    echo check_connection > /sys/class/sec/tsp/cmd && cat /sys/class/sec/tsp/cmd_result
}

monitor_events() {
    getevent | while read event2
    do
        if [[ "$event2" == *"/dev/input/event2: 0001 0074 00000000"* ]]; then
            screentouchfix
        fi
    done
}

screentouchfix
monitor_events &
