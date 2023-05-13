#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libnewt

FILENAME="newt-0.52.23"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  sed -e '/install -m 644 $(LIBNEWT)/ s/^/#/' \
    -e '/$(LIBNEWT):/,/rv/ s/^/#/'          \
    -e 's/$(LIBNEWT)/$(LIBNEWTSH)/g'        \
    -i Makefile.in

  ./configure --prefix=/usr \
    --with-gpm-support \
    --with-python=python3.11

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
