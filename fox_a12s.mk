# MKBOOTIMG
$(shell chmod a+x $(DEVICE_PATH)/prebuilt/mkboot/mkbootimg)

# Device variables
FDEVICE1 := a12s
CURR_DEVICE := a12s

# Color codes for terminal output
RED_BACK := \e[101m
RED := \e[91m
RESET := \e[0m
GREEN := \e[92m

# Important build settings
ALLOW_MISSING_DEPENDENCIES := true
LC_ALL := C

# General configurations
$(info General Configurations)
OF_MAINTAINER := TheDarkDeath788
FOX_BUILD_TYPE := Stable
FOX_VERSION := R12.1_55
FOX_VARIANT := AOSP

# Binary and tool settings
FOX_CUSTOM_BINS_TO_SDCARD := 2
FOX_USE_NANO_EDITOR := 1
FOX_USE_SED_BINARY := 1
FOX_USE_TAR_BINARY := 1
FOX_USE_UNZIP_BINARY := 1
FOX_USE_XZ_UTILS := 1
FOX_USE_ZSTD_BINARY := 1

# Target device configurations
FOX_TARGET_DEVICES := a12s, a12sub, SM-A127M, SM-A127F
TARGET_DEVICE_ALT := a12s, a12sub, SM-A127M, SM-A127F
FOX_BUILD_DEVICE := a12s, a12sub, SM-A127M, SM-A127F

# Function to export build variables
define export_build_vars
    $(info $(GREEN)Exporting build vars from the a12s tree$(RESET))
    # Important build flags
    FOX_DELETE_AROMAFM := 0
    OF_CHECK_OVERWRITE_ATTEMPTS := 1
    OF_WIPE_METADATA_AFTER_DATAFORMAT := 1
    FOX_DELETE_INITD_ADDON := 1  # Note: This can cause bootloops
    FOX_ENABLE_APP_MANAGER := 1
    OF_USE_SAMSUNG_HAPTICS := 1
    OF_USE_TWRP_SAR_DETECT := 1
    OF_QUICK_BACKUP_LIST := /super;/boot;/vbmeta;/dtbo;/efs;/sec_efs
    OF_USE_SYSTEM_FINGERPRINT := 0
    FOX_USE_SPECIFIC_MAGISK_ZIP := $(DEVICE_PATH)/prebuilt/su/APatch.apk

    # Security configurations
    OF_ADVANCED_SECURITY := 1

    # Screen Settings
    OF_STATUS_INDENT_RIGHT := 48
    OF_STATUS_INDENT_LEFT := 48
    OF_STATUS_H := 88
    OF_SCREEN_H := 2400
    OF_OPTIONS_LIST_NUM := 10
    OF_CLOCK_POS := 1

    # Tools and utilities configurations
    OF_USE_LZMA_COMPRESSION := 1
    OF_ENABLE_FS_COMPRESSION := 1
    FOX_RECOVERY_INSTALL_PARTITION := /dev/block/by-name/recovery
    FOX_RECOVERY_VENDOR_PARTITION := /dev/block/mapper/vendor
    FOX_RECOVERY_SYSTEM_PARTITION := /dev/block/mapper/system

    # Maximum permissible splash image size (in KB); do not increase!
    OF_SPLASH_MAX_SIZE := 128

    # Specific features configurations
    OF_NO_TREBLE_COMPATIBILITY_CHECK := 0
    OF_IGNORE_LOGICAL_MOUNT_ERRORS := 1
    OF_USE_HEXDUMP := 1
    OF_ENABLE_LPTOOLS := 1
    FOX_NO_SAMSUNG_SPECIAL := 0
    OF_PATCH_AVB20 := 1
    OF_SUPPORT_VBMETA_AVB2_PATCHING := 1
    OF_NO_SPLASH_CHANGE := 0

    # Flashlight paths configurations
    OF_FL_PATH1 := /system/flashlight
    OF_FL_PATH2 := 
    OF_FLASHLIGHT_ENABLE := 1

    # Log build variables if log file is specified
    if [ -n "$$FOX_BUILD_LOG_FILE" -a -f "$$FOX_BUILD_LOG_FILE" ]; then \
        export | grep "FOX" >> $$FOX_BUILD_LOG_FILE; \
        export | grep "OF_" >> $$FOX_BUILD_LOG_FILE; \
        export | grep "TARGET_" >> $$FOX_BUILD_LOG_FILE; \
        export | grep "TW_" >> $$FOX_BUILD_LOG_FILE; \
    fi
endef

# Function to prompt setting CURR_DEVICE variable
define set_env_var
    $(info $(RED_BACK)Environment Variable CURR_DEVICE not set... Aborting$(RESET))
    $(info Set to the codename of the device you're building for)
    $(info $(GREEN)Example:$(RESET))
    $(info export CURR_DEVICE=a12s)
    exit 1
endef

# Function to handle mismatched CURR_DEVICE variable
define var_not_eq
    $(info $(RED_BACK)CURR_DEVICE not equal to a12s$(RESET))
    $(info $(RED_BACK)CURR_DEVICE = $(CURR_DEVICE)$(RESET))
    $(info $(RED)If this is a mistake, then export CURR_DEVICE to the correct codename$(RESET))
    $(info $(RED)Skipping a12s specific build vars...$(RESET))
endef

# Main logic to export build vars based on the current device
ifeq ($(CURR_DEVICE),$(FDEVICE1))
    $(call export_build_vars)
else ifeq ($(CURR_DEVICE),)
    $(call set_env_var)
else
    $(call var_not_eq)
endif