# Image with the requirements to build Amiberry for x86_64
# Author: Dimitris Panokostas
#
# Usage: docker run --rm -it -v <path-to-amiberry-sources>:/build amiberry-debian-x86_64:latest
#

# If no arg is provided, default to latest
ARG debian_release=latest
ARG sdl3_repo=https://github.com/libsdl-org/SDL.git
ARG sdl3_ref=release-3.2.x
ARG sdl3_image_repo=https://github.com/libsdl-org/SDL_image.git
ARG sdl3_image_ref=release-3.2.x
FROM debian:${debian_release}

ARG sdl3_repo
ARG sdl3_ref
ARG sdl3_image_repo
ARG sdl3_image_ref

LABEL maintainer="Dimitris Panokostas"
LABEL description="Image with the requirements to build Amiberry for Debian x86_64"

RUN apt-get update && \
    apt dist-upgrade -fuy && \
    apt-get install -y --no-install-recommends \
        autoconf ca-certificates git build-essential cmake curl file ninja-build \
        libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev \
        libpng-dev libflac-dev libmpg123-dev libmpeg2-4-dev \
        libserialport-dev libportmidi-dev libenet-dev \
        pkgconf libpcap-dev libzstd-dev && \
    if ! apt-get install -y --no-install-recommends libsdl3-dev libsdl3-image-dev; then \
        sdl3_build_deps='libasound2-dev libdbus-1-dev libdrm-dev libegl1-mesa-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev libglib2.0-dev libibus-1.0-dev libjpeg62-turbo-dev libpulse-dev libsamplerate0-dev libsndio-dev libtiff-dev libudev-dev libwayland-dev libwebp-dev libx11-dev libxcursor-dev libxext-dev libxfixes-dev libxi-dev libxinerama-dev libxkbcommon-dev libxrandr-dev libxrender-dev libxss-dev libxt-dev libxv-dev libxxf86vm-dev'; \
        for optional_pkg in libdecor-0-dev; do \
            if apt-cache show "$optional_pkg" > /dev/null 2>&1; then \
                sdl3_build_deps="$sdl3_build_deps $optional_pkg"; \
            fi; \
        done; \
        apt-get install -y --no-install-recommends $sdl3_build_deps && \
        git clone --depth 1 --branch ${sdl3_ref} ${sdl3_repo} /tmp/SDL && \
        cmake -S /tmp/SDL -B /tmp/SDL/build -G Ninja \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=/usr/local \
            -DSDL_SHARED=ON \
            -DSDL_STATIC=OFF && \
        cmake --build /tmp/SDL/build && \
        cmake --install /tmp/SDL/build && \
        git clone --depth 1 --branch ${sdl3_image_ref} ${sdl3_image_repo} /tmp/SDL_image && \
        cmake -S /tmp/SDL_image -B /tmp/SDL_image/build -G Ninja \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=/usr/local \
            -DSDLIMAGE_SAMPLES=OFF \
            -DSDLIMAGE_TESTS=OFF \
            -DSDLIMAGE_VENDORED=OFF && \
        cmake --build /tmp/SDL_image/build && \
        cmake --install /tmp/SDL_image/build && \
        rm -rf /tmp/SDL /tmp/SDL_image && \
        ldconfig; \
    fi && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /build

CMD [ "bash" ]
