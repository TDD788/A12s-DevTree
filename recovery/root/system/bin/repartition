#!/sbin/sh
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Originally taken from universal repartitioner for the 7870, V1.0, thanks to him
# Written by @Astrako
# Modified for A127F/M
# Hola Astrako, si ves esto quiero pedir mil disculpas por robar tu trabajo, pero estoy manteniendo los creditos, incluso en el post
# New partitions size in Mb. These values are the recommended. Feel free to mod them according your needs
SUPERSIZE=6265
PRISMSIZE=30

SGDISK=/system/bin/sgdisk
DISK=/dev/block/mmcblk0

DISKCODE=`$SGDISK --print $DISK | grep super | awk '{printf $6}'`
SECSIZE=`$SGDISK --print $DISK | grep 'sector size' | awk '{printf $4}'`


function delete() {
	# Delete partitions
	$SGDISK --delete=$1 $DISK
	
}

function calculate() {
	# Get SYSTEM partition number and delete it
	SYSPART=`$SGDISK --print $DISK | grep super | awk '{printf $1}'`
	delete $SYSPART

	# Get VENDOR partition number and delete it, if exists
	PRISMPART=`$SGDISK --print $DISK | grep prism | awk '{printf $1}'`
	delete $PRISMPART

}
	
function repart() {	
	# SYSTEM repartition
    $SGDISK --new=0:0:+${SUPERSIZE}Mib --typecode=0:$DISKCODE --change-name=0:super $DISK

	# VENDOR repartition
	$SGDISK --new=0:0:+${PRISMSIZE}Mib --typecode=0:$DISKCODE --change-name=0:prism $DISK

}

# main
calculate
repart
