#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libsoup

FILENAME="libsoup-3.4.2"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  sed 's/apiversion/soup_version/' -i docs/reference/meson.build

  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dvapi=enabled \
    -Dgssapi=disabled \
    -Dsysprof=disabled \
    --wrap-mode=nofallback

  ninja && ninja install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
