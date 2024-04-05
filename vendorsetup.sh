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
	# Important Value
	export ALLOW_MISSING_DEPENDENCIES=true
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export LC_ALL="C"
	export FOX_VANILLA_BUILD=1
	
	# General Configurations
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export OF_MAINTAINER="TheDarkDeath788"
	export FOX_BUILD_TYPE="Stable"
	export FOX_VERSION="R12.1_35"
	export FOX_DELETE_AROMAFM=0
	export OF_CLOCK_POS=1
	export OF_STATUS_INDENT_RIGHT=48
	export OF_STATUS_INDENT_LEFT=48
	#export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
	export OF_OPTIONS_LIST_NUM=8
	export FOX_DELETE_INITD_ADDON=1 # !- Causes bootloops sometimes -!
	export FOX_VARIANT="AOSP"
	export FOX_ENABLE_APP_MANAGER=1
	export OF_USE_SAMSUNG_HAPTICS=1
	export FOX_USE_SPECIFIC_MAGISK_ZIP="$PWD/device/samsung/a12s/prebuilt/magisk/magdelta.zip"
	
	# Security Configurations
	export OF_ADVANCED_SECURITY=1
	export OF_FORCE_DISABLE_DM_VERITY=1
	export OF_DISABLE_FORCED_ENCRYPTION=1
	
	# Tools and Utilities Configurations
	export OF_USE_LZMA_COMPRESSION=1
	export OF_ENABLE_FS_COMPRESSION=1
	export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/bootdevice/by-name/recovery"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export OF_HIDE_NOTCH=1
	
	# Binaries & Tools
	export FOX_CUSTOM_BINS_TO_SDCARD=2
	
	if [ "$FOX_CUSTOM_BINS_TO_SDCARD" != "" ]; then
		export FOX_USE_NANO_EDITOR=1
		export FOX_USE_SED_BINARY=1
		export FOX_USE_TAR_BINARY=1
		export FOX_USE_UNZIP_BINARY=1
		export FOX_USE_XZ_UTILS=1
	fi
	
	# Important Functions
	export FOX_PORTS_TMP=1
	#export OF_NO_SPLASH_CHANGE=1
	export OF_ENABLE_LPTOOLS=1

	# Specific Features Configurations
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=0
	export FOX_NO_SAMSUNG_SPECIAL=2
	export OF_PATCH_AVB20=1
	export OF_SUPPORT_VBMETA_AVB2_PATCHING=1
	export OF_SCREEN_H=2400
        export FOX_PATCH_VBMETA_FLAG=1

	# File Paths Configurations
	export OF_FL_PATH1="/system/flashlight"
	export OF_FL_PATH2=""
	export OF_FLASHLIGHT_ENABLE=1
	
	# maximum permissible splash image size
	# (in kilobytes); do *NOT* increase!
	export OF_SPLASH_MAX_SIZE=128
	
	# Target Device
	export TARGET_DEVICE_ALT="a12s, a12sub, Fox_a12s"
	export FOX_TARGET_DEVICES="a12s, a12sub, Fox_a12s"
	
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
