#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package jansson

FILENAME="jansson-2.14.tar.bz2"

tar -xvf "./$FILENAME.tar.bz2"

pushd $FILENAME
  ./configure --prefix=/usr --disable-static
  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.bz2"
