#!/bin/sh


## Source the environment variables and functions
. /root/.env && . /root/.functions


echo "Help for IOCD Build (Dockerized build tool for IOCD)"
echo ""
echo "This is a tool to create IOCD self-extracting installers (SFX)"
echo ""
echo "Available scripts:"
echo "  iocd-init      - Initialize the build environment by copying template files."
echo "  iocd-build     - Build the self-extracting installer."
echo "  iocd-help      - Display this help message."
echo ""
echo "Usage:"
echo "  iocd-init"
echo "     Initialize the build environment by copying required build files to the output directory."
echo "  iocd-build"
echo "     Build the self-extracting installer using the files in the output directory, leaving the installer in the output directory."
echo "  iocd-help"
echo "     Display this help message."
echo ""
echo "For more information, refer to the README.md file in the repository."
