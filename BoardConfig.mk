#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a12s

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a15

TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true

TARGET_CPU_SMP := true
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
BOARD_VENDOR := samsung
TARGET_SOC := universal3830
TARGET_BOOTLOADER_BOARD_NAME := exynos850
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_USES_UEFI := true

# Display
TARGET_SCREEN_DENSITY := 300

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=exynos850 androidboot.selinux=enforce loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.usbconfigfs=true
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CONFIG := a12s_defconfig
TARGET_KERNEL_SOURCE := kernel/samsung/a12s
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_ARCH := arm64

#Other
TARGET_KERNEL_ADDITIONAL_FLAGS := \
    HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument"

BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/prebuilt/avb/bootimg.mk

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/twrp-kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/twrp-dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/twrp-dtbo
endif

# Filesystem
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Haptics
TW_USE_SAMSUNG_HAPTICS := true

# MetaData
BOARD_USES_METADATA_PARTITION := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE     := 46137344
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 55574528

BOARD_SUPER_PARTITION_SIZE := 6365921848
BOARD_SUPER_PARTITION_GROUPS := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE := 6365921848
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor \
    product \
    odm

# Rsync error fix or Fixing trying to copy non-existance files
TARGET_COPY_OUT_VENDOR := vendor

# TWRP
# Interface and theme
TW_THEME := portrait_hdpi # Defines the theme used by TWRP.
TW_SCREEN_BLANK_ON_BOOT := true # Controls whether a blank screen is displayed on boot.
TWRP_NEW_THEME := true # Indicates if a new theme is used in TWRP.

# Screen and resolution
TW_FRAMERATE := 60 # Sets the screen refresh rate.
TARGET_SCREEN_WIDTH := 720 # Defines the target screen width.
TARGET_SCREEN_HEIGHT := 1600 # Defines the target screen height.
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888" # Specifies the pixel format for recovery.

# Brightness
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel/brightness" # Path of brightness in the system.
TW_MAX_BRIGHTNESS := 306 # Defines the maximum brightness.
TW_DEFAULT_BRIGHTNESS := 153 # Sets the default brightness.

# TWRP functionality
TW_INCLUDE_FASTBOOTD := true # Indicates if Fastbootd is included.
TW_HAS_FASTBOOTD := true # Indicates if Fastbootd is available.
TW_NO_REBOOT_BOOTLOADER := false # Controls whether reboot to bootloader is allowed.
TW_HAS_DOWNLOAD_MODE := true # Indicates if download mode is available.
TWRP_INCLUDE_LOGCAT := true # Controls the inclusion of logcat logs in TWRP.
TARGET_USES_LOGD := true # Indicates if the system uses the log daemon.
TW_MTP_DEVICE := "Fox MTP A12s" # Indicates the MTP name of the recovery

# File and filesystem compatibility
TW_INCLUDE_NTFS_3G := true # Indicates if NTFS support is included.
TARGET_USES_MKE2FS := true # Defines if mke2fs is used on the target platform.
TW_INCLUDE_FUSE_EXFAT := true # Controls the inclusion of exFAT support.
TW_INCLUDE_RESETPROP := true # Related to resetprop functionality.
TW_INCLUDE_PYTHON := true # Indicates if Python support is included.
TW_INCLUDE_LIBRESETPROP := true # Controls if the resetprop library is included.

# Others
TW_DEVICE_VERSION := 1_Galaxy-A12s # Device version.
RECOVERY_SDCARD_ON_DATA := true # Indicates if recovery SD card is on data partition.
BOARD_HAS_NO_REAL_SDCARD := true # Controls if there is a real SD card.
BOARD_ROOT_EXTRA_FOLDERS := "cache carrier data_mirror efs keyrefuge linkerconfig metadata omr optics bin sys prism" # Defines additional folders in the system root.
BOARD_SUPPRESS_SECURE_ERASE := true # Controls whether secure erase is suppressed.
TW_EXCLUDE_SUPERSU := true # Excludes SuperSU.
TW_INCLUDE_REPACKTOOLS := true # Indicates if repack tools are included.
TW_USE_SAMSUNG_HAPTICS := true # Controls if Samsung haptics are used.
TW_EXCLUDE_TWRPAPP := true # Excludes TWRPApp.
TW_EXCLUDE_APEX := true # Excludes APEX.

PLATFORM_SECURITY_PATCH := 2099-09-09

BOARD_SUPER_PARTITION_SIZE := 6365921848
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE := 6365921848
BOARD_SUPER_PARTITION_GROUPS := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor \
    product \
    odm

# Haptics
TW_USE_SAMSUNG_HAPTICS := true

# ANDROID VERIFIED BOOT
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 0
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flag 0