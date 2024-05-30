#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

MKBOOTIMG := device/samsung/a12s/prebuilt/avb/mkbootimg

FLASH_IMAGE_TARGET ?= $(PRODUCT_OUT)/recovery.tar

LZ4 := lz4

COMPRESSED_KERNEL := $(PRODUCT_OUT)/compressed_kernel.lz4

$(COMPRESSED_KERNEL): $(call bootimage-to-kernel,$(1))
	@echo "----- Compressing kernel with lz4 ------"
	$(hide) $(LZ4) -f $(call bootimage-to-kernel,$(1)) $@

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(COMPRESSED_KERNEL) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) --kernel $(COMPRESSED_KERNEL) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) echo -n "SEANDROIDENFORCE" >> $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo "Made boot image: $@"

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(COMPRESSED_KERNEL) $(recovery_ramdisk) $(RECOVERYIMAGE_EXTRA_DEPS)
	@echo "----- Making recovery image ------"
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) echo -n "SEANDROIDENFORCE" >> $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo "Made recovery image: $@"
