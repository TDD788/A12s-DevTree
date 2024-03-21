LOCAL_PATH := device/samsung/a12s

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Props
PRODUCT_PROPERTY_OVERRIDES +=\
	ro.fastbootd.available=true
	ro.boot.dynamic_partitions=true 
	
# TWRP Fastbootd
TW_INCLUDE_FASTBOOTD := true

# Apex Libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

# TWRP
TW_INCLUDE_PYTHON := true
TW_EXCLUDE_APEX := true