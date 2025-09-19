# Start with a base image that has Wine installed or can install it easily.
FROM ubuntu:22.04


# Install Wine and other necessary packages
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y wget wine xvfb


## The main directory
ARG DIR_BUILD_ROOT="/iocd-build"
ARG DIR_BUILD_TEMPLATE="${DIR_BUILD_ROOT}/template"
ARG DIR_OUTPUT_ROOT="${DIR_BUILD_ROOT}/output"
ARG DIR_INPUT_ROOT="${DIR_BUILD_ROOT}/input"


# Set the working directory
WORKDIR ${DIR_BUILD_ROOT}


## TODO: Put these copy commands in one line?
COPY sfx-installer-example/* ${DIR_BUILD_TEMPLATE}/sfx-installer-example/
COPY sfx-installer-example/custom-installer-files/* ${DIR_BUILD_TEMPLATE}/sfx-installer-example/custom-installer-files/


## Init both "wine" and "ResourceHacker.exe" to create the ~/.wine directory structure and ResourceHacker config files
RUN Xvfb :99 -screen 0 1024x768x24 & DISPLAY=:99 wine ${DIR_BUILD_TEMPLATE}/sfx-installer-example/ResourceHacker.exe -h


## Copy the vscode-server directory so that in-container VS Code works
COPY vscode-server /root/.vscode-server/


## Make sure the important directories exist
RUN mkdir -p ${DIR_INPUT_ROOT}
RUN mkdir -p ${DIR_OUTPUT_ROOT}


# Copy the environment file and scripts into the container
COPY scripts/env.sh /root/.env
RUN echo "source /root/.env" >> /root/.bashrc
COPY scripts/functions.sh /root/.functions
RUN echo "source /root/.functions" >> /root/.bashrc


### Copy the scripts into /usr/bin
COPY scripts/build-iocd.sh /usr/bin/
COPY scripts/init-iocd.sh /usr/bin/
COPY scripts/help-iocd.sh /usr/bin/
## Allow execution
RUN chmod +x /usr/bin/build-iocd.sh
RUN chmod +x /usr/bin/init-iocd.sh
RUN chmod +x /usr/bin/help-iocd.sh
## Link the scripts to /usr/bin for easy access
RUN ln -s /usr/bin/build-iocd.sh /usr/bin/iocd-build
RUN ln -s /usr/bin/init-iocd.sh /usr/bin/iocd-init
RUN ln -s /usr/bin/help-iocd.sh /usr/bin/iocd-help
