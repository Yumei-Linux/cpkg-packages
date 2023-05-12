#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libnotify

FILENAME="libnotify-0.8.2"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dgtk_doc=false \
    -Dman=false

  ninja && ninja install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
