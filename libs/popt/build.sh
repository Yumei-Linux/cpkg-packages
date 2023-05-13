#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package popt

FILENAME="popt-1.19"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  ./configure --prefix=/usr --disable-static
  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
