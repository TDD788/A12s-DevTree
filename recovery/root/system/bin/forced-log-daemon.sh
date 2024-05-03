#!/bin/sh

write_to_kernel_log() {
    local message="$1"
    echo "$message" > /dev/kmsg
}

capture_kernel_logs() {
    local kmsg_logs=$(cat /proc/kmsg)
    local dev_kmsg_logs=$(cat /dev/kmsg)
    local combined_logs="Logs from /proc/kmsg:\n$kmsg_logs\n\nLogs from /dev/kmsg:\n$dev_kmsg_logs"
    echo "$combined_logs"
}

capture_ram_content() {
    
    processes=$(ps)
    kernel_info=$(uname -a)
    kernel_version=$(uname -r)
    os_version=$(uname -o)
    kernel_config=$(cat /proc/config.gz | gunzip)
    kernel_logs=$(capture_kernel_logs)
    ram_content="Processes:\n$processes\n\nKernel Info:\n$kernel_info\n\nKernel Version:\n$kernel_version\n\nOperating System Version:\n$os_version\n\nKernel Configuration:\n$kernel_config\n\nKernel Logs:\n$kernel_logs"
    echo "$ram_content"
}

device_fully_started() {
    if [ "$(getprop sys.boot_completed)" = "1" ]; then
        return 0
    else
        return 1
    fi
}

main() {
    while true; do
        if device_fully_started; then
            break
        fi
        
        LOG_FILE="/cache/daemon-log/forced-log-daemon.log"
        ram_content=$(capture_ram_content)
        write_to_kernel_log "$ram_content"
        LOG_FILE="/data/daemon-log/forced-log-daemon.log"
        ram_content=$(capture_ram_content)
        write_to_kernel_log "$ram_content"
        sleep 5
    done
}

main "$@"