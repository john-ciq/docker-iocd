#!/bin/sh


## Source the environment variables and functions
. /root/.env && . /root/.functions


## Export to the OUTPUT directory; do NOT clobber
cp -arnv ${DIR_BUILD_TEMPLATE}/* ${DIR_OUTPUT_ROOT}
