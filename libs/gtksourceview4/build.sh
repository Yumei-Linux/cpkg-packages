#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package gtksourceview4

FILENAME="gtksourceview-4.8.4"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  mkdir -pv build
  cd build

  meson setup --prefix=/usr --buildtype=release ..
  ninja && ninja install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
