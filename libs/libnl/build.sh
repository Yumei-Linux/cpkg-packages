#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libnl

FILENAME="libnl-3.7.0"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --disable-static

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
