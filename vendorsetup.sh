# MKBOOTIMG
chmod a+x device/samsung/a12s/prebuilt/mkboot/mkbootimg

# Device variables
FDEVICE1="a12s"
CURR_DEVICE="a12s"

# Color codes for terminal output
RED_BACK="\e[101m"
RED="\e[91m"
RESET="\e[0m"
GREEN="\e[92m"

# Important build settings
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL="C"

# General configurations
echo "General Configurations"
export OF_MAINTAINER="TheDarkDeath788"
export FOX_BUILD_TYPE="Stable"
export FOX_VERSION="R12.1_62"
export FOX_VARIANT="AOSP"

# Binary and tool settings
export FOX_CUSTOM_BINS_TO_SDCARD=2
export FOX_USE_NANO_EDITOR=1
export FOX_USE_SED_BINARY=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_UNZIP_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_ZSTD_BINARY=1

# Target device configurations
export FOX_TARGET_DEVICES="a12s, a12sub, SM-A127M, SM-A127F"
export TARGET_DEVICE_ALT="a12s, a12sub, SM-A127M, SM-A127F"
export FOX_BUILD_DEVICE="a12s, a12sub, SM-A127M, SM-A127F"

# Function to export build variables
export_build_vars() {
    echo -e "${GREEN}Exporting build vars from the a12s tree${RESET}"
    # Important build flags
    export FOX_VANILLA_BUILD=1
    export FOX_DELETE_AROMAFM=0
    export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
    export FOX_DELETE_INITD_ADDON=1  # Note: This can cause bootloops
    export FOX_ENABLE_APP_MANAGER=1
    export OF_USE_SAMSUNG_HAPTICS=1
    export OF_USE_TWRP_SAR_DETECT=1
    export OF_QUICK_BACKUP_LIST="/super;/boot;/vbmeta;/dtbo;/efs;/sec_efs"
    export FOX_REPLACE_TOOLBOX_GETPROP=1
    export OF_USE_SYSTEM_FINGERPRINT=1
    export FOX_USE_SPECIFIC_MAGISK_ZIP="device/samsung/a12s/prebuilt/su/Magisk.apk"

    # Security configurations
    export OF_ADVANCED_SECURITY=1

    # Screen Settings
    export OF_STATUS_INDENT_RIGHT=42
    export OF_STATUS_INDENT_LEFT=42
    export OF_STATUS_H=88
    export OF_SCREEN_H=2400
    export OF_OPTIONS_LIST_NUM=10
    export OF_CLOCK_POS=1
    
    # Tools and utilities configurations
    export OF_USE_LZ4_COMPRESSION=1
    # export OF_USE_LZMA_COMPRESSION=1
    export OF_ENABLE_FS_COMPRESSION=1
    export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/by-name/recovery"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"

    # Maximum permissible splash image size (in KB); do not increase!
    export OF_SPLASH_MAX_SIZE=128

    # Specific features configurations
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=0
    export OF_FORCE_DATA_FORMAT_F2FS=1
    export OF_DEFAULT_TIMEZONE="ART3"
    export FOX_COMPRESS_EXECUTABLES=1
    export OF_ENABLE_LPTOOLS=1
    export FOX_NO_SAMSUNG_SPECIAL=0
    export OF_PATCH_AVB20=1
    export OF_SUPPORT_VBMETA_AVB2_PATCHING=1
    export OF_NO_SPLASH_CHANGE=0

    # Flashlight paths configurations
    export OF_FL_PATH1="/system/flashlight"
    export OF_FL_PATH2=""
    export OF_FLASHLIGHT_ENABLE=1

    # Log build variables if log file is specified
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
        export | grep "OF_" >> $FOX_BUILD_LOG_FILE
        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
}

# Function to prompt setting CURR_DEVICE variable
set_env_var() {
    echo -e "${RED_BACK}Environment Variable CURR_DEVICE not set... Aborting${RESET}"
    echo "Set to the codename of the device you're building for"
    echo -e "${GREEN}Example:${RESET}"
    echo " export CURR_DEVICE=a12s"
    exit 1
}

# Function to handle mismatched CURR_DEVICE variable
var_not_eq() {
    echo -e "${RED_BACK}CURR_DEVICE not equal to a12s${RESET}"
    echo -e "${RED_BACK}CURR_DEVICE = $CURR_DEVICE${RESET}"
    echo -e "${RED}If this is a mistake, then export CURR_DEVICE to the correct codename${RESET}"
    echo -e "${RED}Skipping a12s specific build vars...${RESET}"
}

# Main logic to export build vars based on the current device
case "$CURR_DEVICE" in
    "$FDEVICE1")
        export_build_vars
        ;;
    "")
        set_env_var
        ;;
    *)
        var_not_eq
        ;;
esac
