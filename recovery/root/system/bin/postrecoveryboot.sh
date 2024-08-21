#!/system/bin/sh

if [ -f /sbin/from_fox_sd.sh ]; then
   source /sbin/from_fox_sd.sh
fi

gsitouchfix() {
    echo check_connection > /sys/class/sec/tsp/cmd && cat /sys/class/sec/tsp/cmd_result
}

monitor_events() {
    while true; do
        getevent | while read event2; do
            case "$event2" in
                *"/dev/input/event2: 0001 0074 00000000"*)
                    gsitouchfix
                    ;;
            esac
        done
    done
}

gsitouchfix
monitor_events &
