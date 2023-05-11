#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package glib-networking

FILENAME="glib-networking-2.76.0"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dlibproxy=disabled

  ninja && ninja install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
