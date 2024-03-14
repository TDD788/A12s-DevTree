# Mkbootimage
sudo apt install nano
git clone https://gitlab.com/EdwinT2/avb_tool -b main out/host/linux-x86/bin
sudo chmod +rwx out/host/linux-x86/bin/avbtool
chmod a+x device/samsung/a12s/prebuilt/avb/mkbootimg
add_lunch_combo twrp_a12s-eng

FDEVICE1="a12s"
CURR_DEVICE="a12s"

RED_BACK="\e[101m"
RED="\e[91m"
RESET="\e[0m"
GREEN="\e[92m"

export_build_vars(){
	echo -e "${GREEN}Exporting build vars from the a12s tree${RESET}"
	# General Configurations
	export ALLOW_MISSING_DEPENDENCIES=true
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export LC_ALL="C"
	export OF_MAINTAINER="TheDarkDeath788"
	export FOX_BUILD_TYPE="Stable"
	export FOX_VERSION="R12.1_5"
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
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1

	# Security Configurations
	#export OF_ADVANCED_SECURITY=1
	export OF_FORCE_DISABLE_FORCED_ENCRYPTION=1
	export OF_FORCE_DISABLE_DM_VERITY=1
	export OF_DISABLE_FORCED_ENCRYPTION=1
	export OF_FORCE_DISABLE_FORCED_ENCRYPTION=1
	
	# Partition Configurations
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/by-name/recovery"

	# Tools and Utilities Configurations
	export OF_USE_MAGISKBOOT=1
	export OF_USE_LZMA_COMPRESSION=1
	export OF_ENABLE_LPTOOLS=1
	export OF_ENABLE_FS_COMPRESSION=1
	export OF_ALLOW_DISABLE_NAVBAR=0
	export OF_USE_GREEN_LED=0
	export OF_USE_HEXDUMP=1
	export FOX_BUILD_BASH=1
	export OF_NO_ADDITIONAL_MIUI_PROPS_CHECK=1
	export FOX_PORTS_INSTALLER=1
	export FOX_INSTALLER_DISABLE_AUTOREBOOT=0
	
	# Newer Functions For Me Dark (TheDarkDeath788 )
	export OF_CHECK_OVERWRITE_ATTEMPTS=1
	export FOX_VANILLA_BUILD=1
	export FOX_PORTS_TMP=1
	export OF_OTA_BACKUP_STOCK_BOOT_IMAGE=1
	export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1
	export OF_SKIP_FBE_DECRYPTION_SDKVERSION=30
	export OF_TWRP_COMPATIBILITY_MODE=1
	export OF_DONT_KEEP_LOG_HISTORY=1
	export OF_USE_GREEN_LED=1
	export OF_FORCE_USE_RECOVERY_FSTAB=1
	export OF_LOOP_DEVICE_ERRORS_TO_LOG=1
	export FOX_BASH_TO_SYSTEM_BIN=1
	export OF_FORCE_USE_RECOVERY_FSTAB=1
	export OF_FORCE_PREBUILT_KERNEL=1
	
	# maximum permissible splash image size
	# (in kilobytes); do *NOT* increase!
	export OF_SPLASH_MAX_SIZE=104

	# Specific Features Configurations
	export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=0
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export FOX_NO_SAMSUNG_SPECIAL=2
	#export OF_PATCH_AVB20=1
	#export OF_SUPPORT_VBMETA_AVB2_PATCHING=1
	export OF_SCREEN_H=2400
	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1695707220" # [Tue Feb 27 2024 01:07:00 GMT]

	# File Paths Configurations
	export OF_FL_PATH1="/system/flashlight"
	export OF_FL_PATH2=""
	export OF_FLASHLIGHT_ENABLE=1
	
	# Maintainer Avatar
	wget https://raw.githubusercontent.com/TDD788/A12s-DevTree/DT-Builder/recovery/root/TheDarkDeath788.png
	export OF_MAINTAINER_AVATAR="./maintainer.png"

	# Applications Configurations
	export FOX_ENABLE_APP_MANAGER=1

	# Custom Binaries to SD Card Configuration
	export FOX_CUSTOM_BINS_TO_SDCARD=3
	
	
	if [ "$FOX_CUSTOM_BINS_TO_SDCARD" != "" ]; then
		export FOX_USE_NANO_EDITOR=1
		export FOX_USE_SED_BINARY=1
		export FOX_USE_TAR_BINARY=1
		export FOX_USE_UNZIP_BINARY=1
		export FOX_USE_XZ_UTILS=1
		export FOX_REPLACE_BUSYBOX_PS=1
	else
		export FOX_DYNAMIC_SAMSUNG_FIX=1
		export FOX_ASH_IS_BASH=1
		export FOX_USE_BASH_SHELL=1
	fi

	#Ofox 11
	#export FOX_R11=1
	
	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
	  export | grep "FOX" >> $FOX_BUILD_LOG_FILE
	  export | grep "OF_" >> $FOX_BUILD_LOG_FILE
	  export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
	  export | grep "TW_" >> $FOX_BUILD_LOG_FILE
	fi
}

set_env_var(){
        echo -e "${RED_BACK}Environment Variable CURR_DEVICE not set... Aborting${RESET}"
        echo "Set to the codename of the device you're building for"
        echo -e "${GREEN}Example :${RESET}"
        echo " export CURR_DEVICE=a12s"
        exit 1
}

var_not_eq(){
        echo -e "${RED_BACK}CURR_DEVICE not equal to a12s${RESET}"
        echo -e "${RED_BACK}CURR_DEVICE = $CURR_DEVICE${RESET}"
        echo -e "${RED}If this is a mistake, then export CURR_DEVICE to the correct codename${RESET}"
        echo -e "${RED}Skipping a12s specific build vars...${RESET}"
}

case "$CURR_DEVICE" in
  "$FDEVICE1")
    export_build_vars;
    ;;
  "")
    set_env_var
    ;;
  *)
    var_not_eq
    ;;
esac

