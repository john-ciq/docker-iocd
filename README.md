# The Dockerized IOCD Development System
This project is used to Dockerize the build process for IOCD.


# Building

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

# Running

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

### Init a dev environment on disk
This will populate the `iocd-build/output` directory with all the required files to develop a custom installer.
```
docker run --rm --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder iocd-init
```

### Build from a directory on disk
After editing the files, an installer can be built using the `iocd-build` command. It is common to have the same mount used with both the `iocd-init` and `iocd-build` commands.
```
docker run --rm --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder iocd-build
```

### Interactive prompt in the container
This is useful for developing by connecting with a Visual Studio Code instance via the remote container extension.
```
docker run --rm -it -name iocd-builder-console --mount type=bind,src=/path/to/dev/files,target=/iocd-build/output iocd-builder
```
After the container starts, open Visual Studio Code and "Open a Remote Window", selecting "Attach to a Running Container..." and selecting the name of the running interactive container.

## IDE
This image provides a web-based IDE, suitable for editing the development files. Unfortunately, Windows does not permit Docker-in-Docker, so for now, builds must still be performed in a
separate Builder image.
```
docker run --rm -it --mount type=bind,src=/path/to/dev/files/sfx-installer-example,target=/home/coder/project -p 8080:8080 iocd-ide --auth none
```
Then, open a URL to [http://localhost:8080/?folder=/home/coder/project](http://localhost:8080/?folder=/home/coder/project)


## TODO Items
- Create one container with both the IDE and the builder (because Windows does not permit Docker-in-Docker) / get the Builder running in the IDE container
- Get the Node rest example running
- Can the IO server be run from a Docker container?
