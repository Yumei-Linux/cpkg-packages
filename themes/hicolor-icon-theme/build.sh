#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package hicolor-icon-theme

FILENAME="hicolor-icon-theme-0.17"

tar -xvf "./${FILENAME}.tar.xz"

pushd $FILENAME
  ./configure --prefix=/usr
  make install
popd

rm -rf "./$FILENAME.tar.xz" "./$FILENAME"
