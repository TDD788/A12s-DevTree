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
TARGET_ARCH                := arm64
TARGET_ARCH_VARIANT        := armv8-a
TARGET_CPU_ABI             := arm64-v8a
TARGET_CPU_ABI2            := 
TARGET_CPU_VARIANT         := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH                := arm
TARGET_2ND_ARCH_VARIANT        := armv7-a-neon
TARGET_2ND_CPU_ABI             := armeabi-v7a
TARGET_2ND_CPU_ABI2            := armeabi
TARGET_2ND_CPU_VARIANT         := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a15

TARGET_USES_64_BIT_BINDER   := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_BOARD_SUFFIX         := _64

TARGET_CPU_SMP    := true
ENABLE_CPUSETS    := true
ENABLE_SCHEDBOOST := true

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
BOARD_VENDOR                 := samsung
TARGET_SOC                   := universal3830
TARGET_BOOTLOADER_BOARD_NAME := exynos850
TARGET_NO_BOOTLOADER         := false
TARGET_NO_RADIOIMAGE         := true
TARGET_USES_UEFI             := false
TARGET_SCREEN_DENSITY        := 300

# Kernel
BOARD_BOOT_HEADER_VERSION    := 2
BOARD_KERNEL_BASE            := 0x10000000
BOARD_KERNEL_IMAGE_NAME      := Image
BOARD_KERNEL_PAGESIZE        := 4096
BOARD_RAMDISK_OFFSET         := 0x11000000
BOARD_KERNEL_TAGS_OFFSET     := 0x00000100

BOARD_KERNEL_CMDLINE += \
	androidboot.hardware=exynos850 \
	androidboot.selinux=enforcing \
	loop.max_part=35 \
	androidboot.usbcontroller=13600000.dwc3 \
	androidboot.usbconfigfs=true
	reboot=panic_warm \
	androidboot.init_fatal_reboot_target=system

# Compile kernel and DTBs
TARGET_KERNEL_CONFIG         := a12s_defconfig
TARGET_KERNEL_SOURCE         := kernel/samsung/a12s
TARGET_KERNEL_HEADER_ARCH    := arm64
TARGET_KERNEL_ARCH           := arm64
	
# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
    TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
    TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb
    BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
    BOARD_INCLUDE_DTB_IN_BOOTIMG := true
    BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo
    BOARD_KERNEL_SEPARATED_DTBO := true
endif

# MKBOOTARGS
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --board $(TARGET_BOOTLOADER_BOARD_NAME)

BOARD_CUSTOM_BOOTIMG_MK      := $(DEVICE_PATH)/prebuilt/mkboot/bootimg.mk

# Partitions
BOARD_FLASH_BLOCK_SIZE                 := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE         := 46137344
BOARD_RECOVERYIMAGE_PARTITION_SIZE     := 55574528
BOARD_SYSTEMIMAGE_PARTITION_SIZE       := 5368709120
BOARD_VENDORIMAGE_PARTITION_SIZE       := 1073741824
BOARD_SYSTEMIMAGE_PARTITION_TYPE       := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE     := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE   := f2fs

# Rsync error fix or Fixing trying to copy non-existance files
TARGET_COPY_OUT_VENDOR := vendor

# Dynamic partitions and SUPER
BOARD_SUPER_PARTITION_SIZE              := 9126805504
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE    := 9126805504
BOARD_SUPER_PARTITION_GROUPS            := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
	system \
	vendor \
	product \
	odm

# Platform
TARGET_BOARD_PLATFORM := universal3830

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_USERIMAGES_USE_EXT4  := true
TARGET_USERIMAGES_USE_F2FS  := true

# Android Verified Boo
BOARD_AVB_ENABLE                 := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH      := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM     := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX          := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_BUILD_DISABLED_VBMETAIMAGE           := true

# Crypto
PLATFORM_SECURITY_PATCH   := 2099-12-31
VENDOR_SECURITY_PATCH     := 2099-12-31
PLATFORM_VERSION          := 16.1.0
TW_INCLUDE_CRYPTO         := false
TW_INCLUDE_CRYPTO_FBE     := false
TW_INCLUDE_FBE_METADATA_DECRYPT := false

# Device Partitons
BOARD_USES_METADATA_PARTITION   := true
BOARD_USES_VENDOR_DLKMIMAGE     := true
BOARD_USES_SYSTEM_DLKMIMAGE     := true

# TWRP
TW_DEVICE_VERSION    := LTS-UC
TW_THEME             := portrait_hdpi
TW_FRAMERATE         := 60
TW_Y_OFFSET          := 42
TW_H_OFFSET          := -42
TARGET_SCREEN_WIDTH  := 720
TARGET_SCREEN_HEIGHT := 1600

# Screen
TARGET_RECOVERY_PIXEL_FORMAT  := ABGR_8888
TW_BRIGHTNESS_PATH            := /system/backlight/brightness
TW_MAX_BRIGHTNESS             := 306
TW_DEFAULT_BRIGHTNESS         := 153

# TWRP Settings
TARGET_SYSTEM_PROP               := $(DEVICE_PATH)/system.prop
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_NO_REBOOT_BOOTLOADER     := true
TW_USE_TOOLBOX              := true
TW_INPUT_BLACKLIST          := hbtp_vm
TW_HAS_DOWNLOAD_MODE        := true
TW_MTP_DEVICE               := "Galaxy MTP"
TW_USE_NEW_MINADBD          := true
TARGET_USES_MKE2FS          := true
TW_INCLUDE_FUSE_EXFAT       := true
TW_INCLUDE_FUSE_NTFS        := true
TW_INCLUDE_NTFS_3G          := true
TW_SKIP_COMPATIBILITY_CHECK := true

# System as root
BOARD_HAS_LARGE_FILESYSTEM    := true
BOARD_HAS_NO_SELECT_BUTTON    := true
BOARD_SUPPRESS_SECURE_ERASE   := true
BOARD_ROOT_EXTRA_FOLDERS += \
	cache \
	carrier \
	data_mirror \
	efs \
	keyrefuge \
	linkerconfig \
	metadata \
	omr \
	optics \
	spu \
	sys \
	prism

# Making the recovery.img smaller with
# LZMA Compression
LZMA_COMPRESSION := -9
BOARD_RAMDISK_USE_LZMA := true
LZMA_RAMDISK_TARGETS := recovery

# Optimize ramdisk size
TW_INTERNAL_STORAGE_PATH        := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH        := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA  := true

# TWRP flags selected by TDD788
TW_INCLUDE_REPACKTOOLS   := true
TW_EXTRA_LANGUAGES       := true
TW_INCLUDE_FUSE_EXFAT    := true
TW_INCLUDE_RESETPROP     := true
TW_SCREEN_BLANK_ON_BOOT  := true
TWRP_INCLUDE_LOGCAT      := true
TARGET_USES_LOGD         := true
TW_FORCE_CPUINFO_FOR_DEVICE_ID := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/kernel/config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file"

# Exclude from backup
TW_BACKUP_EXCLUSIONS += \
	/data/fonts \
	/data/system/package_cache \
	/data/dalvik-cache \
	/data/cache \
	/data/resource-cache \
	/data/system/graphicsstats \
	/data/local \
	/data/gsi \
	/data/adb

# PBRP
PB_FORCE_DD_FLASH := TRUE

#SHRP
SHRP_PATH                      := device/samsung/a12s
SHRP_MAINTAINER                := TheDarkDeath788
SHRP_DEVICE_CODE               := a12s
SHRP_REC_TYPE                  := Treble
SHRP_DEVICE_TYPE               := A_Only
SHRP_DARK                      := true
SHRP_EXPRESS                   := true
SHRP_STATUSBAR_RIGHT_PADDING   := 40
SHRP_STATUSBAR_LEFT_PADDING    := 40
SHRP_EXTERNAL                  := /external_sd
SHRP_INTERNAL                  := /sdcard
SHRP_OTG                       := /usb_otg
SHRP_REC                       := /dev/block/by-name/recovery
