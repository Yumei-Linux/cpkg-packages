#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libuv

FILENAME="libuv-v1.44.2"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  sh autogen.sh
  ./configure --prefix=/usr --disable-static
  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
