REM  QBFC Project Options Begin
REM  HasVersionInfo: Yes
REM  Companyname: 
REM  Productname: MineCraft Launcher
REM  Filedescription: RaLeX's MineCraft Launcher
REM  Copyrights: RaLeX
REM  Trademarks: 
REM  Originalname: 
REM  Comments: 
REM  Productversion: 01.15.00.00
REM  Fileversion: 01.15.00.00
REM  Internalname: 
REM  Appicon: Z:\games\MineCraft\launcher\includes\icon.ico
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\7za.exe
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\imdiskinst.exe
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\wget.exe
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\splash.png
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\WizApp.exe
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\settings.txt
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\java_portable.txt
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\minecraft.jar
REM  Embeddedfile: Z:\games\MineCraft\launcher\includes\launcher.ver
REM  QBFC Project Options End

:: written by RaLeX
:: Set up enviornment and debugging
setLocal EnableDelayedExpansion
if not exist %systemdrive%\rltmp mkdir %systemdrive%\rltmp
if exist launcher.bat set MYFILES="%cd%\includes"
copy "%MYFILES%\*" %systemdrive%\rltmp
set MYFILES=%systemdrive%\rltmp
if exist logenabled9514753 echo on
if exist logenabled9514753 call :vars>debug-log.txt
if exist logenabled9514753 goto end

:init
if not exist "%cd%\settings.txt" goto generate
if not exist .minecraft mkdir .minecraft

:vars
:: Import settings.txt and set variables
for /f "tokens=* delims= " %%a in (settings.txt) do (
set /a N+=1
set v!N!=%%a
)
set !v6!
set !v7!
set !v11!
set !v12!
set !v16!
set !v17!
set !v18!
set !v22!
set !v23!
set !v27!
set !v31!
set !v32!
set !v36!
set !v37!
set !v41!
set !v42!
set !v43!
set !v47!
set !v51!
set !v55!
set !v56!
set !v60!
set !v64!
set !v65!
set !v69!
set !v70!
set !v71!
set !v72!
set !v73!
set !v74!
set !v75!
set !v76!
set !v77!
set !v78!
set !v79!
set !v83!

:launcherupdate
:: Self-updating feature for the launcher
if exist Launcher.exe.old del /f /q Launcher.exe.old
if not %launcherupdate% == 1 goto modsinstall
start /wait %MYFILES%\wget.exe -Olauncher.ver http://dl.dropbox.com/u/18669020/Launcher/launcher.ver
if not exist launcher.ver goto modsinstall
if not exist .minecraft\launcher.ver echo 0000>.minecraft\launcher.ver
set /p launcherver=<launcher.ver
set /p localver=<.minecraft\launcher.ver
if %launcherver% == %localver% del /f /q launcher.ver
if %launcherver% == %localver% goto modsinstall
start /wait %MYFILES%\wget.exe -OLauncher.exe.update http://dl.dropbox.com/u/18669020/Launcher/Launcher.exe --no-check-certificate>CON
if exist Launcher.exe.update rename Launcher.exe Launcher.exe.old
if exist Launcher.exe.update move /y launcher.ver .minecraft\launcher.ver
if exist Launcher.exe.update rename Launcher.exe.update Launcher.exe
set watitle=Update Downloaded
set watext=Program will now relaunch to apply an update.
start /wait %MYFILES%\WizApp.exe MB
start Launcher.exe
goto end

:modsinstall
if not %custommods% == 1 goto modpack
if exist .minecraft\mods.list goto texturesinstall

:: Folder structure and download/extract base file
if not exist .minecraft\jarfolder mkdir .minecraft\jarfolder
if not exist .minecraft\modzips mkdir .minecraft\modzips
if not exist .minecraft\bin mkdir .minecraft\bin
start /wait %MYFILES%\wget.exe -O%mcver%-base.7z http://dl.dropbox.com/u/18669020/Launcher/%mcver%-base.7z
start /wait %MYFILES%\7za.exe x -y -o.minecraft\bin %mcver%-base.7z
del /f /q %mcver%-base.7z
if not exist .minecraft\bin\minecraft-%mcver%.jar copy /y .minecraft\bin\minecraft.jar .minecraft\bin\minecraft-%mcver%.jar

:: Extract mod zips if set to anything other than "none"
if not %mod1% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod1%" ".minecraft\modzips\%mod1%.zip"
if not %mod2% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod2%" ".minecraft\modzips\%mod2%.zip"
if not %mod3% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod3%" ".minecraft\modzips\%mod3%.zip"
if not %mod4% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod4%" ".minecraft\modzips\%mod4%.zip"
if not %mod5% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod5%" ".minecraft\modzips\%mod5%.zip"
if not %mod6% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod6%" ".minecraft\modzips\%mod6%.zip"
if not %mod7% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod7%" ".minecraft\modzips\%mod7%.zip"
if not %mod8% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod8%" ".minecraft\modzips\%mod8%.zip"
if not %mod9% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod9%" ".minecraft\modzips\%mod9%.zip"
if not %mod10% == none start /wait %MYFILES%\7za.exe x -y -o".minecraft\modzips\%mod10%" ".minecraft\modzips\%mod10%.zip"

:: Extract/copy jar files
start /wait %MYFILES%\7za.exe x -y -o.minecraft\jarfolder .\.minecraft\bin\minecraft.jar
rmdir /s /q .minecraft\jarfolder\META-INF
if not %mod1% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod1%\*" .minecraft\jarfolder
if not %mod2% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod2%\*" .minecraft\jarfolder
if not %mod3% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod3%\*" .minecraft\jarfolder
if not %mod4% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod4%\*" .minecraft\jarfolder
if not %mod5% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod5%\*" .minecraft\jarfolder
if not %mod6% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod6%\*" .minecraft\jarfolder
if not %mod7% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod7%\*" .minecraft\jarfolder
if not %mod8% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod8%\*" .minecraft\jarfolder
if not %mod9% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod9%\*" .minecraft\jarfolder
if not %mod10% == none xcopy /e /q /h /r /y /i /c ".minecraft\modzips\%mod10%\*" .minecraft\jarfolder
rmdir /s /q ".minecraft\modzips\%mod1%"
rmdir /s /q ".minecraft\modzips\%mod2%"
rmdir /s /q ".minecraft\modzips\%mod3%"
rmdir /s /q ".minecraft\modzips\%mod4%"
rmdir /s /q ".minecraft\modzips\%mod5%"
rmdir /s /q ".minecraft\modzips\%mod6%"
rmdir /s /q ".minecraft\modzips\%mod7%"
rmdir /s /q ".minecraft\modzips\%mod8%"
rmdir /s /q ".minecraft\modzips\%mod9%"
rmdir /s /q ".minecraft\modzips\%mod10%"

:: Pack jar with extracted files
del /f /q .minecraft\bin\minecraft.jar
start /wait %MYFILES%\7za.exe a -y .\.minecraft\bin\minecraft.jar .\.minecraft\jarfolder\*
rmdir /s /q .minecraft\jarfolder

:: Create mod list for reference
del /f /q .minecraft\mods.list
echo ---------- >> .minecraft\mods.list
echo %mcver% >> .minecraft\mods.list
echo ---------- >> .minecraft\mods.list
echo 1. %mod1% >> .minecraft\mods.list
echo 2. %mod2% >> .minecraft\mods.list
echo 3. %mod3% >> .minecraft\mods.list
echo 4. %mod4% >> .minecraft\mods.list
echo 5. %mod5% >> .minecraft\mods.list
echo 6. %mod6% >> .minecraft\mods.list
echo 7. %mod7% >> .minecraft\mods.list
echo 8. %mod8% >> .minecraft\mods.list
echo 9. %mod9% >> .minecraft\mods.list
echo 10. %mod10% >> .minecraft\mods.list

goto texturesinstall

:modpack
:: Install modpack if not installed but enabled
if not %modpack% == 1 goto texturesupdate
if exist .minecraft\mods.ver goto modsupdate
start /wait %MYFILES%\wget.exe http://dl.dropbox.com/u/18669020/Launcher/%mcver%-mods.7z --no-check-certificate>CON
if exist %mcver%-mods.7z start /wait %MYFILES%\wget.exe -O.minecraft\mods.ver http://dl.dropbox.com/u/18669020/Launcher/mods.ver --no-check-certificate
start /wait %MYFILES%\7za.exe x -y -o.minecraft %mcver%-mods.7z
del /f /q %mcver%-mods.7z
goto texturesupdate

:modsupdate
:: Update modpack if versions not equal
if not %modsupdate% == 1 goto texturesupdate
start /wait %MYFILES%\wget.exe -Omods.ver http://dl.dropbox.com/u/18669020/Launcher/mods.ver
if not exist mods.ver goto texturesinstall
set /p modscurrentver=<mods.ver
set /p modslocalver=<.minecraft\mods.ver
if %modscurrentver% == %modslocalver% del /f /q mods.ver
if %modscurrentver% == %modslocalver% goto texturesinstall
start /wait %MYFILES%\wget.exe http://dl.dropbox.com/u/18669020/Launcher/%mcver%-update.7z --no-check-certificate>CON
if exist %mcver%-update.7z del /f /q .minecraft\mods\*.zip
if exist %mcver%-update.7z del /f /q .minecraft\mods\*.litemod
if exist %mcver%-update.7z del /f /q .minecraft\mods\*.jar
if exist %mcver%-update.7z del /f /q .minecraft\coremods\*.jar
start /wait %MYFILES%\7za.exe x -y -o.minecraft %mcver%-update.7z
del /f /q %mcver%-update.7z
del /f /q mods.ver

:texturesinstall
:: Install texture pack if not installed but enabled
if not %textures% == 1 goto settingsver
if exist .minecraft\textures.ver goto texturesupdate
if NOT exist .minecraft\texturepacks mkdir .minecraft\texturepacks
start /wait %MYFILES%\wget.exe -O.minecraft\texturepacks\ralex-textures.zip http://dl.dropbox.com/u/18669020/Launcher/%mcver%-textures.zip --no-check-certificate>CON
if exist .minecraft\texturepacks\ralex-textures.zip start /wait %MYFILES%\wget.exe -O.minecraft\textures.ver http://dl.dropbox.com/u/18669020/Launcher/textures.ver
goto settingsver

:texturesupdate
:: Update texture pack if versions not equal
if not %texturesupdate% == 1 goto settingsver
start /wait %MYFILES%\wget.exe -Otextures.ver http://dl.dropbox.com/u/18669020/Launcher/textures.ver
if not exist textures.ver goto settingsver
set /p texturescurrentver=<textures.ver
set /p textureslocalver=<.minecraft\textures.ver
if %texturescurrentver% == %textureslocalver% del /f /q textures.ver
if %texturescurrentver% == %textureslocalver% goto settingsver
start /wait %MYFILES%\wget.exe -O.minecraft\texturepacks\ralex-textures.zip http://dl.dropbox.com/u/18669020/Launcher/%mcver%-textures.zip --no-check-certificate>CON
move /y textures.ver .minecraft

:settingsver
:: Update settings if versions not equal
if not %launcherupdate% == 1 goto import
start /wait %MYFILES%\wget.exe -Osettings.ver http://dl.dropbox.com/u/18669020/Launcher/settings.ver
set /p settingsnewver=<settings.ver
if %settingsnewver% == %settingsver% del /f /q settings.ver
if %settingsnewver% == %settingsver% goto import
rename settings.txt settings.old.txt
start /wait %MYFILES%\wget.exe -Osettings.txt http://dl.dropbox.com/u/18669020/Launcher/settings.txt
set watitle=Update Downloaded
set watext=Settings file updated. Old settings renamed to settings.old.txt - Program will now exit.
start /wait %MYFILES%\WizApp.exe MB
del /f /q settings.ver
goto end

:import
:: Import old MineCraft settings/configs
if not %importold% == 1 goto init2
if exist .minecraft\imported.txt goto init2
copy /y "%appdata%\.minecraft\options.txt" .minecraft
copy /y "%appdata%\.minecraft\optionsof.txt" .minecraft
copy /y "%appdata%\.minecraft\servers.dat" .minecraft
copy /y "%appdata%\.minecraft\lastlogin" .minecraft
xcopy /e /q /h /r /y /i /c "%appdata%\.minecraft\config" .minecraft\config
xcopy /e /q /h /r /y /i /c "%appdata%\.minecraft\mods" .minecraft\mods
xcopy /e /q /h /r /y /i /c "%appdata%\.minecraft\resources" .minecraft\resources
xcopy /e /q /h /r /y /i /c "%appdata%\.minecraft\texturepacks" .minecraft\texturepacks
xcopy /e /q /h /r /y /i /c "%appdata%\.minecraft\saves" .minecraft\saves
xcopy /e /q /h /r /y /i /c "%appdata%\.minecraft\stats" .minecraft\stats
echo Successfully imported local MineCraft settings. Delete this file to allow reimporting.>.minecraft\imported.txt

:init2
if %delold% == 1 rmdir /s /q "%appdata%\.minecraft"
if not %killproc% == 1 goto task
taskkill /F /IM javaw.exe
taskkill /F /IM java.exe

:task
if %ramdisk% == 1 goto start
set appdata=%cd%
if NOT exist .minecraft\minecraft.jar goto mkmc
goto start

:mkmc
:: Copy over Mojang launcher if not present
if not exist "%appdata%\.minecraft" mkdir "%appdata%\.minecraft"
copy /y %MYFILES%\minecraft.jar "%appdata%\.minecraft"
if NOT exist "%appdata%\.minecraft\minecraft.jar" goto end

:start
:: Set java path and arguments
if exist "C:\Program Files\Java\jre6\bin\java.exe" set javap="C:\Program Files\Java\jre6\bin\java.exe"
if exist "C:\Program Files (x86)\Java\jre6\bin\java.exe" set javap="C:\Program Files (x86)\Java\jre6\bin\java.exe"
if exist "C:\Program Files\Java\jre7\bin\java.exe" set javap="C:\Program Files\Java\jre7\bin\java.exe"
if exist "C:\Program Files (x86)\Java\jre7\bin\java.exe" set javap="C:\Program Files (x86)\Java\jre7\bin\java.exe"
if exist java\bin\java.exe set javap="%cd%\java\bin\java.exe"
if %javacustom% == 1 set javap=%javapath%
echo set javap=%javap% -splash:%MYFILES%\splash.png
if %autoserver% == 0 set serverset=
if %autoserver% == 1 set serverset=%server%
if %user% == changeme set autologin=0
if %phost% == none set proxyargs=
if %phost% == none goto startmc
set proxyargs=-DsocksProxyHost=%phost% -DsocksProxyPort=%pport%

:startmc
if %ramdisk% == 1 goto raminit
if %nologin% == 1 goto nologin
goto mc

:instrd
:: Install ramdisk if not present
start /wait %MYFILES%\imdiskinst.exe -y
if NOT exist "%windir%\system32\imdisk.exe" goto end
goto ramft

:raminit
if NOT exist "%windir%\system32\imdisk.exe" goto instrd

:ramft
:: Create ramdisk and prepare for file copying
imdisk -a -t vm -s 300MB -p "/fs:fat /q /y" -m %ramdrv%:
set appdata=%ramdrv%:

:ramcopy
if NOT exist "%cd%\.minecraft\minecraft.jar" goto mkmc
if NOT exist "%appdata%\.minecraft" mkdir "%appdata%\.minecraft"
xcopy /e /q /h /r /y /i /c .minecraft "%appdata%\.minecraft"

:javaram
xcopy /e /q /h /r /y /i /c java "%appdata%\java"
if exist "%appdata%\java\bin\java.exe" set javap="%appdata%\java\bin\java.exe"
if %nologin% == 1 goto nologin
goto mcram

:nologin
%javap% -Xms%Xms%M -Xmx%Xmx%M -XX:+UseFastAccessorMethods -XX:+AggressiveOpts -XX:+DisableExplicitGC -XX:+UseAdaptiveGCBoundary -XX:MaxGCPauseMillis=500 -XX:SurvivorRatio=16 -XX:+UseParallelGC -XX:UseSSE=3 -XX:ParallelGCThreads=2 -cp "%appdata%\.minecraft\bin\minecraft.jar";"%appdata%\.minecraft\bin\lwjgl.jar";"%appdata%\.minecraft\bin\lwjgl_util.jar";"%appdata%\.minecraft\bin\jinput.jar" -Djava.library.path="%appdata%\.minecraft\bin\natives" net.minecraft.client.Minecraft
if %ramdisk% == 1 goto ramclean

:mc
if %autologin% == 0 set user=
if %autologin% == 0 set pass=
if %autologin% == 0 set serverset=
%javap% %proxyargs% -Xms%Xms%M -Xmx%Xmx%M -XX:+UseFastAccessorMethods -XX:+AggressiveOpts -XX:+DisableExplicitGC -XX:+UseAdaptiveGCBoundary -XX:MaxGCPauseMillis=500 -XX:SurvivorRatio=16 -XX:+UseParallelGC -XX:UseSSE=3 -XX:ParallelGCThreads=2 -jar "%appdata%\.minecraft\minecraft.jar" %user% %pass% %serverset%
goto end

:mcram
if %autologin% == 0 set user=
if %autologin% == 0 set pass=
if %autologin% == 0 set serverset=
%javap% %proxyargs% -Xms%Xms%M -Xmx%Xmx%M -XX:+UseFastAccessorMethods -XX:+AggressiveOpts -XX:+DisableExplicitGC -XX:+UseAdaptiveGCBoundary -XX:MaxGCPauseMillis=500 -XX:SurvivorRatio=16 -XX:+UseParallelGC -XX:UseSSE=3 -XX:ParallelGCThreads=2 -jar "%appdata%\.minecraft\minecraft.jar" %user% %pass% %serverset%

:ramclean
if not %persist% == 1 goto ramdiskclean
if not exist .minecraft mkdir .minecraft
xcopy /e /q /h /r /y /i /c "%appdata%\.minecraft" .minecraft

:ramdiskclean
"%windir%\system32\imdisk.exe" -D -m %ramdrv%:
goto end

:generate
if not exist MineCraft mkdir MineCraft
if exist Launcher.exe move /y Launcher.exe MineCraft
set cd=%cd%\MineCraft
cd "%cd%"

:structure
mkdir .minecraft
mkdir .minecraft\mods
copy /y %MYFILES%\minecraft.jar .minecraft

:settings
copy /y %MYFILES%\launcher.ver .minecraft
copy /y %MYFILES%\settings.txt .
if not exist settings.txt goto end

:mkjavaport
if exist java\java_portable.txt goto mkjavaport2
mkdir java
if exist java copy /y "%MYFILES%\java_portable.txt" java

:setupnotify
set watitle=Setup Complete
set watext=Files/Folders have been created for first launch. Configure settings.txt and restart the launcher.
start /wait %MYFILES%\WizApp.exe MB

:end
if exist Dropbox rmdir /s /q Dropbox
rmdir /s /q %MYFILES%
goto infinity
