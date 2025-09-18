@echo off
setlocal

del custom-installer-files.7z > nul
cd custom-installer-files
call ..\7z.exe a -y ..\custom-installer-files.7z *
cd ..
copy /y /b 7zSD-nonadmin.sfx + config.txt + custom-installer-files.7z sfx-installer.exe
rem to extract rc file:
rem ResourceHacker.exe -open sfx-installer.exe  -save info.rc -action extract -mask VersionInfo,, -log con
rem then edit by hand
ResourceHacker.exe -open info.rc -save info.res -action compile -log con
ResourceHacker.exe -open sfx-installer.exe  -save sfx-installer.exe -action addoverwrite -res info.res -mask VersionInfo,, -log con
ResourceHacker.exe -open sfx-installer.exe  -save sfx-installer.exe -action addoverwrite -res installer-icon-composite.ico -mask ICONGROUP,1, -log con
ResourceHacker.exe -open sfx-installer.exe  -save sfx-installer.exe -action addoverwrite -res installer-icon-composite.ico -mask ICONGROUP,101, -log con
if exist ie4uinit.exe call ie4uinit.exe show
if exist ie4uinit.exe call ie4uinit.exe -ClearIconCache
if exist IconsRefresh.exe call IconsRefresh.exe
call verify > nul
