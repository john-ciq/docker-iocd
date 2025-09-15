# Start with a base image that has Wine installed or can install it easily.
FROM ubuntu:22.04

# Install Wine and other necessary packages
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y wget wine xvfb gedit
## xeyes
## gedit


# Set the working directory
WORKDIR /app

# Copy the rcedit.exe and the target executable
COPY rcedit-x86.exe /app/
COPY Notepad.exe /app/
COPY ResourceHacker.exe /app/
COPY ie4uinit.exe /app/
COPY installer-icon-composite.ico /app/

## Setup wine
RUN wine -h


COPY Notepad.exe /app/sfx-installer.exe


## RUN xvfb-run wine /app/rcedit-x86.exe "Notepad.exe" --set-version-string "FileDescription" "My Awesome App"
## RUN xvfb-run wine /app/ResourceHacker.exe -open Notepad.exe  -save info.rc -action extract -mask VersionInfo,, -log con

## THIS WORKS:
## From xterm on local xquartz server, run "xhost +"
##   docker run -e DISPLAY=host.docker.internal:0 petedavidson887/xclock:0.0.1


## trying:
## docker run --rm -it -e DISPLAY=docker.for.mac.host.internal:0 test

## docker run -e DISPLAY=docker.for.mac.host.internal:0 petedavidson887/xclock:0.0.1



# FROM alpine
# # FROM monokrome/wine

# RUN apk update

# # Install wget
# # RUN apt-get install -y wget
# # RUN apk add wget wine xvfb
# RUN apk add wget wine xvfb-run xeyes

# COPY ie4uinit.exe .
# COPY ResourceHacker.exe .

# # Download and install Resource Hacker
# # RUN wget "http://www.angusj.com/resourcehacker/reshack_setup.exe"
# # RUN wget "https://www.angusj.com/resourcehacker/reshacker_setup.exe"
# # RUN xvfb-run -a wine reshack_setup.exe /sp- /silent /norestart /dir="Z:\opt\reshack"
# # RUN rm reshack_setup.exe


# ## docker run --rm -it -e DISPLAY=host.docker.internal:0.0 test
# ## libvulcan.so.1
# ## libgnutls
# # ENTRYPOINT ["xvfb-run", "-a", "wine", "/opt/reshack/ResHacker.exe"]
## ENTRYPOINT ["xvfb-run", "-a", "wine", "/app/ResourceHacker.exe -open Notepad.exe  -save info.rc -action extract -mask VersionInfo,, -log con"]



## produce-sfx-installer.bat
# @echo off
# setlocal

# del custom-installer-files.7z > nul
# cd custom-installer-files
# call ..\7z.exe a -y ..\custom-installer-files.7z *
# cd ..
# copy /y /b 7zSD-nonadmin.sfx + config.txt + custom-installer-files.7z sfx-installer.exe
# rem to extract rc file:



## xvfb-run wine /app/ResourceHacker.exe -open sfx-installer.exe  -save info.rc -action extract -mask VersionInfo,, -log con

# rem then edit by hand
# xvfb-run wine ResourceHacker.exe -open info.rc -save info.res -action compile -log con


# xvfb-run wine ResourceHacker.exe -open sfx-installer.exe  -save sfx-installer.exe -action addoverwrite -res info.res -mask VersionInfo,, -log con


# xvfb-run wine ResourceHacker.exe -open sfx-installer.exe  -save sfx-installer.exe -action addoverwrite -res installer-icon-composite.ico -mask ICONGROUP,1, -log con


# xvfb-run wine ResourceHacker.exe -open sfx-installer.exe  -save sfx-installer.exe -action addoverwrite -res installer-icon-composite.ico -mask ICONGROUP,101, -log con


# if exist ie4uinit.exe call ie4uinit.exe show
# if exist ie4uinit.exe call ie4uinit.exe -ClearIconCache
# if exist IconsRefresh.exe call IconsRefresh.exe
# call verify > nul


## TODO: wine config during image creation
