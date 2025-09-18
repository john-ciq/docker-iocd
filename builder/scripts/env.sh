#!/bin/sh


## These environment variables are used by the scripts in the iocd scripts
export DIR_BUILD_ROOT=/iocd-build
export DIR_BUILD_TEMPLATE=${DIR_BUILD_ROOT}/template
export DIR_OUTPUT_ROOT=${DIR_BUILD_ROOT}/output
export DIR_INPUT_ROOT=${DIR_BUILD_ROOT}/input

## The display variable for Xvfb
export DISPLAY=:99
