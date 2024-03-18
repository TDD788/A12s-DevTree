LOCAL_PATH := device/samsung/a12s

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd
    #android.hardware.fastboot@1.0-impl-mock.recovery \

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
#TW_EXCLUDE_APEX := true