#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libgudev

FILENAME="libgudev-237"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release

  ninja && ninja install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
