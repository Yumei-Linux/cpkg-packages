#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package nghttp2

FILENAME="nghttp2-1.53.0"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --disable-static \
    --enable-lib-only \
    --docdir=/usr/share/doc/nghttp2-1.53.0

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
