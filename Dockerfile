# Image with the requirements to build Amiberry for x86_64
# Author: Dimitris Panokostas
# Version: 1.0
# Date: 2022-06-07
#
# Usage: docker run --rm -it -v <path-to-amiberry-sources>:/build amiberry-docker-x86_64:latest
#
FROM ubuntu:latest

RUN apt-get update && apt-get install -y autoconf git build-essential libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libpng-dev libflac-dev libmpg123-dev libmpeg2-4-dev pkgconf

WORKDIR /build

CMD [ "bash"]
