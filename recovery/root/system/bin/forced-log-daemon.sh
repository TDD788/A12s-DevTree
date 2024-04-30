#!/bin/sh

# Check and create logging directory in /cache/Daemon
LOG_CACHE_DIR="/cache/daemon-log"
if [ ! -d "$LOG_CACHE_DIR" ]; then
    toybox mkdir -p "$LOG_CACHE_DIR"
fi

# Check and create logging directory in /data/Daemon
LOG_DATA_DIR="/data/daemon-log"
if [ ! -d "$LOG_DATA_DIR" ]; then
    toybox mkdir -p "$LOG_DATA_DIR"
fi

# Function to write to the log file
write_to_log() {
    local message="$1"
    local section="$2"
    local random_number=$((1 + RANDOM % 1000000))
    local timestamp=$(date +%s)
    echo "$timestamp - $section - $random_number - $message" >> "$LOG_FILE"
}

# Function to capture RAM content
capture_ram_content() {
    # Accessing RAM content directly is not safe and not recommended
    # Instead, we'll simulate by capturing the output of system commands
    
    # Capture processes
    processes=$(toybox ps)

    # Capture kernel information
    kernel_info=$(toybox uname -a)
    
    # Capture kernel version
    kernel_version=$(toybox uname -r)
    
    # Capture operating system version
    os_version=$(toybox uname -o)
    
    # Capture kernel configuration
    kernel_config=$(toybox cat /proc/config.gz | toybox gunzip)
    
    # Capture kernel logs from logcat
    kernel_logs_logcat=$(logcat -v time -d)
    
    # Capture kernel logs from /dev/kmsg
    kernel_logs_kmsg_proc=$(cat /proc/kmsg)
    kernel_logs_kmsg_dev=$(cat /dev/kmsg)

    # Combine captured information
    ram_content="Processes:\n$processes\n\nKernel Info:\n$kernel_info\n\nKernel Version:\n$kernel_version\n\nOperating System Version:\n$os_version\n\nKernel Configuration:\n$kernel_config\n\nKernel Logs (pstore):\n$kernel_logs_pstore\n\nKernel Logs (logcat):\n$kernel_logs_logcat\n\nKernel Logs (kmsg):\n$kernel_logs_kmsg"
    
    # Return the combined content
    echo "$ram_content"
}

# Function to check if the device has fully started
device_fully_started() {
    # Check if recovery has started (you might need to adjust this condition)
    if [ "$(getprop sys.boot_completed)" = "1" ]; then
        return 0
    else
        return 1
    fi
}

# Main function
main() {
    while true; do
        # Check if the device has fully started
        if device_fully_started; then
            break
        fi
        
        # Function to determine the name of the LOG
        local message="$1"
        local section="$2"
        local random_number=$((1 + RANDOM % 1000000))
  	  local timestamp=$(date +%s)
  	  echo "$timestamp - $section - $random_number - $message"
        
        # Log file in /cache/Daemon
        LOG_FILE="$LOG_CACHE_DIR/forced-log-daemon.log"
        
        # Capture RAM content
        ram_content=$(capture_ram_content)
        
        # Write RAM content to log file
        write_to_log "$ram_content" "RAM Content"
        
        # Log file in /data/Daemon
        LOG_FILE="$LOG_DATA_DIR/forced-log-daemon.log"
        
        # Capture RAM content again
        ram_content=$(capture_ram_content)
        
        # Write RAM content to log file
        write_to_log "$ram_content" "RAM Content"
        
        # Wait for a while before checking again
        sleep 5
    done
}

# Start the script
main "$@"