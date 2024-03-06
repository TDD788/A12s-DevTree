#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
DEVICE_PATH := device/samsung/a12s

# Release name
PRODUCT_RELEASE_NAME := a12s

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit device configuration

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# TWRP
TW_INCLUDE_FASTBOOTD := true
TW_INCLUDE_FASTBOOT := true

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery
    
PRODUCT_PACKAGES += \
    fastboot_recovery
    
# TWRP
TW_HAS_FASTBOOTD := true
TW_HAS_FASTBOOT := true
    
PRODUCT_PROPERTY_OVERRIDES +=\
	ro.fastbootd.available=true
	ro.fastboot.available=true
	ro.boot.dynamic_partitions=true 
	
# Apex Libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

TW_EXCLUDE_APEX := true

#TWRP Flags
TW_INCLUDE_PYTHON := true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/root,recovery/root)

## Device identifier. This must come after all inclusions
PRODUCT_NAME := twrp_a12s
PRODUCT_DEVICE := a12s
PRODUCT_MODEL := SM-A127x
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
