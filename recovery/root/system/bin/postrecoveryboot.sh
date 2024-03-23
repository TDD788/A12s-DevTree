#!/sbin/sh -x
   	cmd="sym"
   	chmod +x /sdcard/Fox/FoxFiles/bin/*
   	if [ "$cmd" = "cp" ]; then
           [ -d /sdcard/Fox/FoxFiles/bin/nano/ ] && mv /sbin/nano /sbin/nano_script
           cp -af /sdcard/Fox/FoxFiles/bin/* /sbin/
           [ -d /sdcard/Fox/FoxFiles/bin/nano/ ] && { cp -af /sdcard/Fox/FoxFiles/bin/nano/ /FFiles/nano/; rm -rf /sbin/nano/; mv -f /sbin/nano_script /sbin/nano; }
           [ -f /sdcard/Fox/FoxFiles/bin/nano ] && cp -af /sdcard/Fox/FoxFiles/bin/nano /system/bin/
   	else
	   files="aapt bash gnused gnutar lzma zip"
	   set -- $files
	   while [ -n "$1" ]
  	   do
     	      i="$1"
     	      [ -f /sdcard/Fox/FoxFiles/bin/"$i" ] && { rm -f /sbin/$i; ln -sf /sdcard/Fox/FoxFiles/bin/$i /sbin/$i; }
     	      shift
  	   done
  	   [ -f /sdcard/Fox/FoxFiles/bin/nano ] && { rm -f /system/bin/nano; ln -sf /sdcard/Fox/FoxFiles/bin/nano /system/bin/nano; }
   	fi
   	[ -f /sdcard/Fox/FoxFiles/bin/lzma ] && { rm -f /sbin/xz; ln -sf lzma /sbin/xz; }
	exit 0;
