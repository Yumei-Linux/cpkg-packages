#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package mousepad

FILENAME="mousepad-0.5.10"

tar -xvf "./$FILENAME.tar.bz2"

pushd $FILENAME
  ./configure --prefix=/usr --enable-keyfile-settings
  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.bz2"
