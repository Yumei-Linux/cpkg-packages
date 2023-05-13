#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libarchive

FILENAME="libarchive-3.6.2"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure --prefix=/usr --disable-static
  make && make install
  sed -i "s/iconv //" /usr/lib/pkgconfig/libarchive.pc
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
