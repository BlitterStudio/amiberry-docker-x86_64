# amiberry-docker-x86_64

A Dockerfile which creates an image with all requirements to build Amiberry for a Debian-based `x86_64` platform (e.g. Ubuntu x86_64).

The image is based on Debian:latest and includes all Amiberry dependencies (e.g. SDL2, SDL2-image, etc)

The full image is available on DockerHub: <https://hub.docker.com/repository/docker/midwan/amiberry-debian-x86_64>

## Usage

```bash
docker run --rm -it -v <dir-you-cloned-amiberry-into>:/build midwan/amiberry-debian-x84_64:latest
```

Then you can proceed to compile Amiberry as usual, e.g.:

```bash
cmake -B build && cmake --build build
```

## Building the image locally

To build the image yourself:

```bash
docker build -t amiberry-debian-x86_64:latest .
```

## CI/CD

Images are automatically built and pushed to DockerHub via GitHub Actions on every push to `main` and on a daily schedule.
