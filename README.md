# amiberry-docker-x86_64

A Dockerfile which creates an image, with the requirements to build Amiberry for the `x86_64` platform (e.g. Ubuntu x86_64).

The image is based on Ubuntu:latest and includes all Amiberry dependencies (e.g. SDL2, SDL2-image, etc)

The full image is available on DockerHub: <https://hub.docker.com/repository/docker/midwan/amiberry-debian-x86_64>

## Usage

`docker run --rm -it -v <dir-you-cloned-amiberry-into>:/build midwan/amiberry-debian-x84_64:latest`

Then you can proceed to compile Amiberry as usual, e.g. `make -j8 PLATFORM=x86-64`
