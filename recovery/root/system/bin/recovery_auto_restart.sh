#!/system/bin/sh

COUNTER_FILE="/cache/recovery/recovery_counter"
MAX_RETRIES=5

current_count=$(cat $COUNTER_FILE)
new_count=$((current_count + 1))

echo $new_count > $COUNTER_FILE

if [ $new_count -ge $MAX_RETRIES ]; then
    echo "Reiniciando al sistema después de múltiples reinicios en recovery."
    /system/bin/reboot
fi
