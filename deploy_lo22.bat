@echo off
del classes.dex
del HTC_IME_lo22.apk
"C:\Program Files (x86)\Java\jdk1.6.0_18\bin\java" -jar baksmali-1.2.2.jar -o IME\asm IME\bin\classes.dex
copy IME\asm\jonasl\ime\Static*.smali lo22\jonasl
copy IME\asm\jonasl\ime\Container.smali lo22\jonasl
copy IME\asm\jonasl\ime\SwipeTracker.smali lo22\jonasl
copy IME\asm\jonasl\ime\Extra*.smali lo22\jonasl
copy IME\asm\jonasl\ime\Prefs*.smali lo22\jonasl
copy IME\asm\jonasl\ime\Res.smali lo22\jonasl
"C:\Program Files (x86)\Java\jdk1.6.0_18\bin\java" -jar smali-1.2.2.jar -o classes.dex lo22
zip -u HTC_IME_lo22_unsigned.apk classes.dex
"C:\Program Files (x86)\Java\jdk1.6.0_18\bin\jarsigner" -keystore keys/jlo.keystore -storepass password -signedjar HTC_IME_lo22_unaligned.apk HTC_IME_lo_unsigned.apk jlo.keystore
"C:\android-sdk-windows\tools\zipalign" 4 HTC_IME_lo_unaligned.apk HTC_IME_lo22.apk
del HTC_IME_lo22_unaligned.apk
del classes.dex
"C:\android-sdk-windows\tools\adb" install -r HTC_IME_lo22.apk