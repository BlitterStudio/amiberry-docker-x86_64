# Image with the requirements to build Amiberry for x86_64
# Author: Dimitris Panokostas
#
# Usage: docker run --rm -it -v <path-to-amiberry-sources>:/build amiberry-debian-x86_64:latest
#

# If no arg is provided, default to latest
ARG debian_release=latest
FROM debian:${debian_release}

LABEL maintainer="Dimitris Panokostas"
LABEL description="Image with the requirements to build Amiberry for Debian x86_64"

RUN apt-get update && \
    apt dist-upgrade -fuy && \
    apt-get install -y --no-install-recommends \
        autoconf git build-essential cmake ninja-build \
        libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev \
        libpng-dev libflac-dev libmpg123-dev libmpeg2-4-dev \
        libserialport-dev libportmidi-dev libenet-dev \
        pkgconf libpcap-dev libzstd-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /build

CMD [ "bash" ]
