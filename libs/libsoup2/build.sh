#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libsoup2

FILENAME="libsoup-2.74.3"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dvapi=enabled \
    -Dgssapi=disabled \
    -Dsysprof=disabled

  ninja && ninja install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
