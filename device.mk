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

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Apex Libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

TW_EXCLUDE_APEX := true

PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys-intf/display

PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    android.hardware.fastboot@1.0-impl-mock

PRODUCT_SHIPPING_API_LEVEL := 33


TW_INCLUDE_PYTHON := true

BOARD_USES_QCOM_FBE_DECRYPTION := true

# Properties
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental"

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

TW_EXCLUDE_DEFAULT_USB_INIT := true
