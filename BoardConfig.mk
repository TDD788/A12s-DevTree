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
TARGET_ARCH			:= arm64
TARGET_ARCH_VARIANT		:= armv8-a
TARGET_CPU_ABI 			:= arm64-v8a
TARGET_CPU_ABI2			:= 
TARGET_CPU_VARIANT 		:= generic
TARGET_CPU_VARIANT_RUNTIME      := generic

TARGET_2ND_ARCH			:= arm
TARGET_2ND_ARCH_VARIANT		:= armv7-a-neon
TARGET_2ND_CPU_ABI              := armeabi-v7a
TARGET_2ND_CPU_ABI2 		:= armeabi
TARGET_2ND_CPU_VARIANT		:= generic
TARGET_2ND_CPU_VARIANT_RUNTIME  := cortex-a15

TARGET_USES_64_BIT_BINDER   := true
TARGET_SUPPORTS_64_BIT_APPS := true

TARGET_CPU_SMP     := true
ENABLE_CPUSETS 	   := true
ENABLE_SCHEDBOOST  := true

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
BOARD_VENDOR		      := samsung
TARGET_SOC 	              := universal3830
TARGET_BOOTLOADER_BOARD_NAME  := exynos850
TARGET_NO_BOOTLOADER 	      := true
TARGET_NO_RADIOIMAGE 	      := true
TARGET_USES_UEFI	      := true

# Kernel
BOARD_BOOTIMG_HEADER_VERSION  := 2
BOARD_KERNEL_BASE 	      :=0x10000000
BOARD_KERNEL_IMAGE_NAME       := Image
BOARD_KERNEL_PAGESIZE 	      := 2048
BOARD_RAMDISK_OFFSET	      := 0x01000000
BOARD_KERNEL_TAGS_OFFSET      := 0x00000100

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

BOARD_KERNEL_CMDLINE += \
	androidboot.hardware=exynos850 \
	androidboot.selinux=permissive \
	loop.max_part=15 \
	androidboot.usbcontroller=13600000.dwc3 \
	androidboot.usbconfigfs=true

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO  := true

TARGET_KERNEL_CONFIG	  := a12s_defconfig
TARGET_KERNEL_SOURCE	  := kernel/samsung/a12s
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_ARCH	  := arm64

# Other
TARGET_KERNEL_ADDITIONAL_FLAGS := \
    HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument"

BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/prebuilt/avb/bootimg.mk

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL       := $(DEVICE_PATH)/prebuilt/suf-kernel
#TARGET_PREBUILT_KERNEL	     := $(DEVICE_PATH)/prebuilt/Image.gz
TARGET_PREBUILT_DTB 	     := $(DEVICE_PATH)/prebuilt/twrp-dtb
BOARD_MKBOOTIMG_ARGS 	     += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := 
BOARD_PREBUILT_DTBOIMAGE     := $(DEVICE_PATH)/prebuilt/twrp-dtbo
BOARD_KERNEL_SEPARATED_DTBO  := 
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE	             := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE 	     := 46137344
BOARD_RECOVERYIMAGE_PARTITION_SIZE   := 55574528
BOARD_HAS_LARGE_FILESYSTEM	     := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE     := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE   := ext4

# Rsync error fix or Fixing trying to copy non-existance files
TARGET_COPY_OUT_VENDOR := vendor

BOARD_SUPER_PARTITION_SIZE		       := 9126805504
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE           := 9126805504
BOARD_SUPER_PARTITION_GROUPS		       := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor \
    product \
    odm

# Platform
TARGET_BOARD_PLATFORM	   := universal3830    

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_USERIMAGES_USE_EXT4  := true
TARGET_USERIMAGES_USE_F2FS  := true

# ANDROID VERIFIED BOOT
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX 	           := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_KEY_PATH	           := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM     	   := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX	   := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS           += --flag 3

# Crypto
PLATFORM_SECURITY_PATCH		 := 2099-12-31
VENDOR_SECURITY_PATCH 		 := 2021-08-01
PLATFORM_VERSION 		 := 16.1.0
TW_INCLUDE_CRYPTO 		 := false
TW_INCLUDE_CRYPTO_FBE	         := false
TW_INCLUDE_FBE_METADATA_DECRYPT	 := false
BOARD_USES_METADATA_PARTITION 	 := true

# TWRP
TW_DEVICE_VERSION	  := Galaxy-A12s
TW_THEME		  := portrait_hdpi
TW_FRAMERATE		  := 60
TARGET_SCREEN_WIDTH 	  := 720
TARGET_SCREEN_HEIGHT 	  := 1600
RECOVERY_SDCARD_ON_DATA   := true

# Screen
TARGET_RECOVERY_PIXEL_FORMAT := "ABGR_8888"
TW_BRIGHTNESS_PATH	     := "/sys/class/backlight/panel/brightness"
TW_MAX_BRIGHTNESS            := 306
TW_DEFAULT_BRIGHTNESS        := 153

# TWRP Settings
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_USE_TOOLBOX		    := true
TW_NO_REBOOT_BOOTLOADER     := false
TW_HAS_DOWNLOAD_MODE        := true
TW_MTP_DEVICE		    := "Fox MTP A12s"
TW_INCLUDE_NTFS_3G	    := true
TW_USE_NEW_MINADBD	    := true
TW_INPUT_BLACKLIST	    := "hbtp_vm"
TARGET_USES_MKE2FS	    := true

# Making the recovery.img smaller
BOARD_HAS_NO_REAL_SDCARD    := true

# System as root
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
    	bin \
    	sys \
    	prism
    	
BOARD_SUPPRESS_SECURE_ERASE := true

# TWRP flags selected by TDD788
TW_INCLUDE_REPACKTOOLS 	    := true
TW_EXTRA_LANGUAGES	    := true
TWRP_INCLUDE_LOGCAT	    := true
TARGET_USES_LOGD	    := true
TW_INCLUDE_FUSE_EXFAT	    := true
TW_INCLUDE_RESETPROP	    := true
TW_USE_SAMSUNG_HAPTICS	    := true
TW_NO_SCREEN_TIMEOUT	    := true
TW_SCREEN_BLANK_ON_BOOT	    := true
TW_INCLUDE_FB2PNG	    := true
TW_ALWAYS_RMRF 		    := true
