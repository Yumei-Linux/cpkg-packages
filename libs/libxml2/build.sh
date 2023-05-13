#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libxml2

FILENAME="libxml2-2.10.4"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --disable-static \
    --with-history \
    PYTHON=/usr/bin/python3 \
    --docdir=/usr/share/doc/libxml2-2.10.4

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
