# The Dockerized IOCD Development System
This project is used to Dockerize the build process for IOCD. With the exception of `io-connect-installer.exe`, this Docker container provides all files and tools required to develop
a customized IOCD SFX installer.

# Building the Images

## Builder
```
cd builder
docker build -t iocd-builder .
```

## IDE
```
cd ide
docker build-t iocd-ide
```

# Running the Images

## Builder
It is likely that developers will want to persist work on disk. For this, the Builder container allows exporting the dev files. This is done by mounting a directory from the
host machine into the Docker container. For these examples, `/path/to/dev/files` is considered to be a directory on the host machine where dev work will reside.

In general, this is accomplished by using the `--mount` command line argument at runtime. On Windows, this looks like:
```
docker run --rm --mount type=bind,src=c:\path\to\dev\files,target=/iocd-build/output iocd-builder iocd-builder
```

With a Linux environment, the command looks like:
```
docker run --rm --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder iocd-builder
```

This README will use the Linux mount style.

### Init a DEV Environment on Disk
This will populate the `iocd-build/output` directory with all the required files to develop a custom installer.
```
docker run --rm --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder iocd-init
```

### Build From a Directory on Disk
After editing the files, an installer can be built using the `iocd-build` command. It is common to have the same mount used with both the `iocd-init` and `iocd-build` commands.
```
docker run --rm --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder iocd-build
```

NOTE: The `io-connect-installer.exe` file needs to be available to the Docker container, in the `/iocd-build/output/sfx-installer-example/custom-installer-files/` directory
in order for the custom installer to function correctly.

### Interactive Building Container
This is useful for developing by connecting with a Visual Studio Code instance via the remote container extension.
```
docker run --rm -it --name iocd-builder-console --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder
```
After the container starts, open Visual Studio Code and "Open a Remote Window", selecting "Attach to a Running Container..." and selecting the name of the running interactive
container. The terminal will run inside the container so the following commands are available:
- iocd-init
- iocd-build
- iocd-help

## IDE
This image provides a web-based IDE, suitable for editing the development files. Unfortunately, Windows does not permit Docker-in-Docker, so for now, builds must still be performed in a
separate Builder container. However, both the IDE and Builder containers may use the same mount (though it is preferred to use Docker volumes in this case).
```
docker run --rm --name iocd-ide --mount type=bind,src=/path/to/dev/files/sfx-installer-example,target=/home/coder/project -p 8080:8080 iocd-ide --auth none
```
Then, open a URL to [http://localhost:8080/?folder=/home/coder/project](http://localhost:8080/?folder=/home/coder/project)

# Moving Files
It is possible to run a self-contained Docker container with no on-disk mounts. This is transient but might be useful for ephemeral builds. It is likely that files need to
be transferred between the host machine and the Docker container. It is useful to use the `--name` parameter when starting a Docker container so it can be easily referenced.
For example, consider the builder image launched with `--name iocd-builder-console`; the container name is `iocd-builder-console`.

# Typical Developer Flows

## Persistent
1. Start the Builder container
   - `docker run --rm -it --name iocd-builder-console --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder`
2. Copy `io-connect-installer.exe` to `/path/to/dev/files/sfx-installer-example/custom-installer-files/io-connect-installer.exe`
3. Start Visual Studio Code
4. Connect to the remote container
5. Run the init script (if needed)
   - From the VSC terminal: `iocd-init`
6. Make any config or customizations required
7. Build the installer
   - From the VSC terminal: `iocd-build`
8. The installer will be in the host machine at `/path/to/dev/files/sfx-installer-example/sfx-installer.exe`

## Ephemeral
1. Start the Builder container
   - `docker run --rm -it --name iocd-builder-console --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder`
2. Initialize the dev environment
   - From the Builder container: `iocd-init`
3. Copy `io-connect-installer` to the Builder container (`/iocd-build/output/sfx-installer-example/custom-installer-files/io-connect-installer.exe`)
   - `docker cp /path/to/io-connect-installer.exe iocd-builder-console:/iocd-build/output/sfx-installer-example/custom-installer-files/io-connect-installer.exe`
4. Start the IDE container
   - `docker run --rm --name iocd-ide --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output -p 8080:8080 iocd-ide`
5. Open a browser to the web IDE
   - [http://localhost:8080/?folder=/home/coder/project](http://localhost:8080/?folder=/home/coder/project)
6. Make any config or customizations required
7. Build the installer
   - From the Builder container: `iocd-build`
8. Copy the installer to the host machine
   - `docker cp iocd-builder-console:/iocd-build/output/sfx-installer-example/sfx-installer.exe MyInstaller`

## Adding your installer to the output folder
```
docker cp /path/to/io-connect-installer.exe iocd-builder-console:/iocd-build/output/sfx-installer-example/custom-installer-files/
```

## Extracting the built installer
This will copy the built SFX installer to the current directory, with the filename `MyInstaller`
```
docker cp iocd-builder-console:/iocd-build/output/sfx-installer-example/sfx-installer.exe MyInstaller
```

## TODO Items
- Create a rest-server container for running
- Create one container with both the IDE and the builder (because Windows does not permit Docker-in-Docker) / get the Builder running in the IDE container
- Add a web page which (perhaps running in an nginx or apache container) which provides a UI to created batch/sh files for starting the containers (based on mount dirs, etc.)
- Get the Node rest example running
- Can the IO server be run from a Docker container?
