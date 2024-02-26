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

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd
    
# TWRP
TW_INCLUDE_FASTBOOTD := true
TW_HAS_FASTBOOTD := true
    
PRODUCT_PROPERTY_OVERRIDES +=\
	ro.fastbootd.available=true
	ro.boot.dynamic_partitions=true 
	
# TWRP
TW_INCLUDE_FASTBOOTD := true
TW_HAS_FASTBOOTD := true

# Apex Libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

TW_EXCLUDE_APEX := true

#TWRP Flags

TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_PYTHON := true

