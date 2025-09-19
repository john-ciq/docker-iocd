#!/bin/sh


## Source the environment variables and functions
. /root/.env && . /root/.functions


## Paths to important directories and files
DIR_SFX_INSTALLER=${DIR_OUTPUT_ROOT}/sfx-installer-example
FILE_CUSTOM_INSTALLER_FILES_7Z=${DIR_SFX_INSTALLER}/custom-installer-files.7z


## Paths to required executables
EXE_7ZIP=${DIR_BUILD_TEMPLATE}/sfx-installer-example/7z.exe
EXE_RESOURCEHACKER=${DIR_BUILD_TEMPLATE}/sfx-installer-example/ResourceHacker.exe


## Clean up any previous build artifacts
rm -f ${FILE_CUSTOM_INSTALLER_FILES_7Z} > /dev/null


## Build the SFX installer
run_wine ${EXE_7ZIP} a ${FILE_CUSTOM_INSTALLER_FILES_7Z} ${DIR_SFX_INSTALLER}/custom-installer-files/*
cat ${DIR_SFX_INSTALLER}/7zSD-nonadmin.sfx ${DIR_SFX_INSTALLER}/config.txt ${DIR_SFX_INSTALLER}/custom-installer-files.7z > ${DIR_SFX_INSTALLER}/sfx-installer.exe
##
## Update the version info and icon in the SFX installer
run_wine ${EXE_RESOURCEHACKER} -open ${DIR_SFX_INSTALLER}/info.rc -save ${DIR_SFX_INSTALLER}/info.res -action compile -log con
run_wine ${EXE_RESOURCEHACKER} -open ${DIR_SFX_INSTALLER}/info.rc -save ${DIR_SFX_INSTALLER}/info.res -action compile -log conwine ${DIR_BUILD_TEMPLATE}/sfx-installer-example/ResourceHacker.exe -open ${DIR_SFX_INSTALLER}/sfx-installer.exe  -save ${DIR_SFX_INSTALLER}/sfx-installer.exe -action addoverwrite -res info.res -mask VersionInfo,, -log con
run_wine ${EXE_RESOURCEHACKER} -open ${DIR_SFX_INSTALLER}/sfx-installer.exe  -save ${DIR_SFX_INSTALLER}/sfx-installer.exe -action addoverwrite -res ${DIR_SFX_INSTALLER}/installer-icon-composite.ico -mask ICONGROUP,1, -log con
run_wine ${EXE_RESOURCEHACKER} -open ${DIR_SFX_INSTALLER}/sfx-installer.exe  -save ${DIR_SFX_INSTALLER}/sfx-installer.exe -action addoverwrite -res ${DIR_SFX_INSTALLER}/installer-icon-composite.ico -mask ICONGROUP,101, -log con
