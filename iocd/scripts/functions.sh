#!/bin/sh


## Source the environment variables
. /root/.env


## Functions to wrap Xvfb and wine
## TODO: Should these functions be moved to a separate script and sourced instead?
##
## Function to start Xvfb if it's not already running; no-op otherwise
run_xvfb() {
    if pgrep -x "Xvfb" > /dev/null; then
        echo > /dev/null
    else
        echo "Xvfb is not running. Starting it now..."
        Xvfb ${DISPLAY} -screen 0 1024x768x24 &
    fi
}

## Function to run a command using wine, ensuring Xvfb is running first
run_wine() {
    run_xvfb && wine "$@"
}
