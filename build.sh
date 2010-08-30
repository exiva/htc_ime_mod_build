#!/bin/sh
#Build HTC_IME for all platforms
#Ported from jonasl's batch scripts

#make Lowres 2.2 ime
if [ "`echo $1`" = "makefroyolo" ];
then
	mkdir lo22
	cp -R lo/ lo22/
	rm -rf lo22/com/htc/android/htcime/voice
	mkdir lo22/com/htc/android/htcime/voice
	cp -r hi22/com/htc/android/htcime/voice/ lo22/com/htc/android/htcime/voice/
	cp HTC_IME_lo_unsigned.apk HTC_IME_lo22_unsigned.apk
	echo "Created Low Res FroYo 2.2"	
#htc_ime lo
elif [ "`echo $1`" = "lo" ];
then
	rm classes.dex
	rm HTC_IME_lo.apk

	java -jar baksmali-1.2.2.jar -o IME/asm IME/bin/classes.dex

	cp IME/asm/jonasl/ime/Static*.smali lo/jonasl
	cp IME/asm/jonasl/ime/Container.smali lo/jonasl
	cp IME/asm/jonasl/ime/SwipeTracker.smali lo/jonasl
	cp IME/asm/jonasl/ime/Extra*.smali lo/jonasl
	cp IME/asm/jonasl/ime/Prefs*.smali lo/jonasl
	cp IME/asm/jonasl/ime/Res.smali lo/jonasl
	
	java -jar smali-1.2.2.jar -o classes.dex lo
	
	#create zip file
	zip -u HTC_IME_lo_unsigned.apk classes.dex
	
	#sign jar
	jarsigner -keystore keys/jlo.keystore -storepass password -signedjar HTC_IME_lo_unaligned.apk HTC_IME_lo_unsigned.apk jlo.keystore

	#zipalign (this requires the android sdk to be in your path.)
	zipalign 4 HTC_IME_lo_unaligned.apk HTC_IME_lo.apk
	
	#rm old files
	rm classes.dex
	rm HTC_IME_lo_unaligned.apk
	
	#create dist archive
	if [ "`echo $2`" = "dist" ];
	then
		zip htc_ime_jonasl_lo HTC_IME_lo.apk Clicker.apk README.txt
	#install via adb
	elif [ "`echo $2`" = "install" ];
	then
		adb install -r HTC_IME_lo.apk
		adb install -r Clicker.apk
	fi
	
	echo "Built HTC_IME Low res"
elif [ "`echo $1`" = "lo22" ];
then
	rm classes.dex
	rm HTC_IME_lo22.apk
	
	java -jar baksmali-1.2.2.jar -o IME/asm IME/bin/classes.dex

	cp IME/asm/jonasl/ime/Static*.smali lo22/jonasl
	cp IME/asm/jonasl/ime/Container.smali lo22/jonasl
	cp IME/asm/jonasl/ime/SwipeTracker.smali lo22/jonasl
	cp IME/asm/jonasl/ime/Extra*.smali lo22/jonasl
	cp IME/asm/jonasl/ime/Prefs*.smali lo22/jonasl
	cp IME/asm/jonasl/ime/Res.smali lo22/jonasl
	
	java -jar smali-1.2.2.jar -o classes.dex lo22
	
	#create zip file
	zip -u HTC_IME_lo_unsigned.apk classes.dex
	
	#sign jar
	jarsigner -keystore keys/jlo.keystore -storepass password -signedjar HTC_IME_lo22_unaligned.apk HTC_IME_lo22_unsigned.apk jlo.keystore

	#zipalign (this requires the android sdk to be in your path.)
	zipalign 4 HTC_IME_lo22_unaligned.apk HTC_IME_lo22.apk
	
	#rm old files
	rm classes.dex
	rm HTC_IME_lo22_unaligned.apk
	
	#create dist archive
	if [ "`echo $2`" = "dist" ];
	then
		zip htc_ime_jonasl_lo22 HTC_IME_lo22.apk Clicker.apk README.txt
	#install via adb
	elif [ "`echo $2`" = "install" ];
	then
		adb install -r HTC_IME_lo22.apk
		adb install -r Clicker.apk
	fi
	
	echo "Built HTC_IME low 2.2 res"
elif [ "`echo $1`" = "lo15" ];
then
	rm classes.dex
	rm HTC_IME_lo.apk

	java -jar baksmali-1.2.2.jar -o IME/asm IME/bin/classes.dex
	
	cp IME/asm/jonasl/ime/Static*.smali lo15/jonasl
	cp IME/asm/jonasl/ime/Container.smali lo15/jonasl
	cp IME/asm/jonasl/ime/SwipeTracker.smali lo15/jonasl
	cp IME/asm/jonasl/ime/Extra*.smali lo15/jonasl
	cp IME/asm/jonasl/ime/Prefs*.smali lo15/jonasl
	cp IME/asm/jonasl/ime/Res.smali lo15/jonasl
	
	java -jar smali-1.2.2.jar -o classes.dex lo15
	
	#create zip file
	zip -u HTC_IME_lo15_unsigned.apk classes.dex
	
	#sign jar
	jarsigner -keystore keys/jlo.keystore -storepass password -signedjar HTC_IME_lo15_unaligned.apk HTC_IME_lo15_unsigned.apk jlo.keystore
	
	#zipalign
	zipalign 4 HTC_IME_lo15_unaligned.apk HTC_IME_lo15.apk
	
	#clean up
	rm HTC_IME_lo15_unaligned.apk
	rm classes.dex
	
	#create dist archive
	if [ "`echo $2`" = "dist" ];
	then
		zip htc_ime_jonasl_lo15 HTC_IME_lo15.apk Clicker.apk README.txt
	#install via adb
	elif [ "`echo $2`" = "install" ];
	then
		adb install -r HTC_IME_lo15.apk
		adb install -r Clicker.apk
	fi
	
	echo "Built HTC_IME Low Res 1.5+"
elif [ "`echo $1`" = "hi" ];
then

	rm classes.dex
	rm HTC_IME_hi.apk

	java -jar baksmali-1.2.2.jar -o IME/asm IME/bin/classes.dex
	
	cp IME/asm/jonasl/ime/Static*.smali hi/jonasl
	cp IME/asm/jonasl/ime/Container.smali hi/jonasl
	cp IME/asm/jonasl/ime/SwipeTracker.smali hi/jonasl
	cp IME/asm/jonasl/ime/Extra*.smali hi/jonasl
	cp IME/asm/jonasl/ime/Prefs*.smali hi/jonasl
	cp IME/asm/jonasl/ime/Res.smali hi/jonasl
	
	java -jar smali-1.2.2.jar -o classes.dex hi
	
	#zip
	zip -u HTC_IME_hi_unsigned.apk classes.dex
	
	#sign
	jarsigner -keystore keys/jlo.keystore -storepass password -signedjar HTC_IME_hi_unaligned.apk HTC_IME_hi_unsigned.apk jlo.keystore
	
	#align
	zipalign 4 HTC_IME_hi_unaligned.apk HTC_IME_hi.apk
	
	rm HTC_IME_hi_unaligned.apk
	rm classes.dex
	
	#build clicker
	rm Clicker_hi.apk
	java -jar smali-1.2.2.jar -o classes.dex hi_Clicker
	zip -u Clicker_hi_unsigned.apk classes.dex
	jarsigner -keystore keys/jlo.keystore -storepass password -signedjar Clicker_hi_unaligned.apk Clicker_hi_unsigned.apk jlo.keystore
	zipalign 4 Clicker_hi_unaligned.apk Clicker_hi.apk
	rm Clicker_hi_unaligned.apk
	rm classes.dex
	echo "Built HTC_IME High Res 1.5+"
	
	#create dist archive
	if [ "`echo $2`" = "dist" ];
	then
		zip htc_ime_jonasl_hi HTC_IME_hi.apk Clicker_hi.apk README.txt
	#install via adb
	elif [ "`echo $2`" = "install" ];
	then
		adb install -r HTC_IME_hi.apk
		adb install -r Clicker_hi.apk
	fi
	
elif [ "`echo $1`" = "hi22" ];
then

	rm classes.dex
	rm HTC_IME_hi22.apk

	java -jar baksmali-1.2.2.jar -o IME/asm IME/bin/classes.dex
	
	cp IME/asm/jonasl/ime/Static*.smali hi22/jonasl
	cp IME/asm/jonasl/ime/Container.smali hi22/jonasl
	cp IME/asm/jonasl/ime/SwipeTracker.smali hi22/jonasl
	cp IME/asm/jonasl/ime/Extra*.smali hi22/jonasl
	cp IME/asm/jonasl/ime/Prefs*.smali hi22/jonasl
	cp IME/asm/jonasl/ime/Res.smali hi22/jonasl
	
	java -jar smali-1.2.2.jar -o classes.dex hi22
	
	zip -u HTC_IME_hi22_unsigned.apk classes.dex
	
	jarsigner -keystore keys/jlo.keystore -storepass password -signedjar HTC_IME_hi22_unaligned.apk HTC_IME_hi22_unsigned.apk jlo.keystore
	
	zipalign 4 HTC_IME_hi22_unaligned.apk HTC_IME_hi22.apk
	
	rm HTC_IME_hi22_unaligned.apk
	rm classes.dex
	
	#build clicker
	del Clicker_hi.apk
 	java -jar smali-1.2.2.jar -o classes.dex hi_Clicker
	zip -u Clicker_hi_unsigned.apk classes.dex
	jarsigner -keystore keys/jlo.keystore -storepass password -signedjar Clicker_hi_unaligned.apk Clicker_hi_unsigned.apk jlo.keystore
	zipalign 4 Clicker_hi_unaligned.apk Clicker_hi.apk
	rm Clicker_hi_unaligned.apk
	rm classes.dex

	#create dist archive
	if [ "`echo $2`" = "dist" ];
	then
		zip htc_ime_jonasl_hi22 HTC_IME_hi22.apk Clicker_hi.apk README.txt
	#install via adb
	elif [ "`echo $2`" = "install" ];
	then
		adb install -r HTC_IME_hi22.apk
		adb install -r Clicker_hi.apk
	fi
else
	echo "HTC_IME Mod build script"
	echo "Usage: build.sh <type> <options>"
	echo "Available Types:"
	echo "makefroyolo - Create Low Res FroYo IME"
	echo "lo15	    - Builds 1.5 Low-Res IME (No voice support)"
	echo "lo	    - Builds 1.6-2.1 IME (Voice Support)"
	echo "lo22	    - Builds 2.2 IME (FroYo Voice Support)"
	echo "hi	    - Builds 1.6-2.1 High-Res IME (Voice Support)"
	echo "hi22	    - Builds 2.2 High-Res IME (FroYo Voice Support)"
	echo "Available Options:"
	echo "dist	    - Creates ZIP Archive for distribution"
	echo "install	    - Installs IME Via ADB"
fi