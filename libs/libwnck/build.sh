#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libwnck

FILENAME="libwnck-43.0"

tar -xvf "./${FILENAME}.tar.xz"

pushd $FILENAME
  mkdir -pv build
  cd build

  meson setup --prefix=/usr \
    --buildtype=release ..

  ninja && ninja install
popd

rm -rf "./$FILENAME.tar.xz" "./$FILENAME"
