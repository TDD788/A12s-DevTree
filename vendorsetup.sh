# General Configurations
export ALLOW_MISSING_DEPENDENCIES=true
export TARGET_ARCH="arm64"
export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
export LC_ALL="C"
export OF_MAINTAINER="TheDarkDeath788"
export FOX_BUILD_TYPE="In-Dev"
export FOX_VERSION="Jello"
export FOX_TARGET_DEVICES="SM-A127M, SM-A127F, a12s"
export FOX_BUILD_DEVICE="a12s"
export OF_CLASSIC_LEDS_FUNCTION=0
export FOX_DELETE_AROMAFM=0
export OF_CLOCK_POS=1
export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
export OF_FORCE_PREBUILT_KERNEL=1
export OF_NO_SPLASH_CHANGE=0
export OF_STATUS_INDENT_RIGHT=48
export OF_STATUS_INDENT_LEFT=48
export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
export OF_OPTIONS_LIST_NUM=8

# Partition Configurations
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/by-name/recovery"

# Security Configurations
export OF_ADVANCED_SECURITY=1
export OF_KEEP_DM_VERITY=1
export OF_DISABLE_FORCED_ENCRYPTION=1
export OF_FORCE_DISABLE_FORCED_ENCRYPTION=1

# Tools and Utilities Configurations
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_USE_LZMA_COMPRESSION=1
export FOX_REPLACE_BUSYBOX_PS=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_SED_BINARY=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_UNZIP_BINARY=1
export FOX_USE_XZ_UTILS=1
export OF_ENABLE_LPTOOLS=1
export OF_ENABLE_FS_COMPRESSION=1
export OF_FIX_DECRYPTION_ON_DATA_MEDIA=1

# Specific Features Configurations
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=0
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export FOX_VARIANT="AOSP"
export OF_FLASHLIGHT_ENABLE=1
export FOX_NO_SAMSUNG_SPECIAL=2
export FOX_PATCH_VBMETA_FLAG=1
export OF_PATCH_AVB20=1
export OF_SUPPORT_VBMETA_AVB2_PATCHING=1
export OF_SCREEN_H=2400
export PLATFORM_SECURITY_PATCH="2099-12-31"
export TW_DEFAULT_LANGUAGE="en"
export OF_USE_TWRP_SAR_DETECT=1

# File Paths Configurations
export OF_FL_PATH1="/sys/devices/virtual/camera/flash/rear_flash"
export OF_FL_PATH2="1"
#export OF_MAINTAINER_AVATAR="${GITHUB_WORKSPACE}/OrangeFox/fox_${{ github.event.inputs.MANIFEST_BRANCH }}/out/target/product/${{ github.event.inputs.DEVICE_NAME }}/maintainer.png"
export OF_MAINTAINER_AVATAR="/home/runner/work/A12s-DevTree/A12s-DevTree/OrangeFox/fox_12.1/device/samsung/a12s/maintainer.png"

# Applications Configurations
export FOX_ENABLE_APP_MANAGER=1

# Custom Binaries to SD Card Configuration
export FOX_CUSTOM_BINS_TO_SDCARD=1
