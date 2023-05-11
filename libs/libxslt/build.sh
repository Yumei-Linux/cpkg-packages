#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libxslt

FILENAME="libxslt-1.1.38"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/libxslt-1.1.38 \
    PYTHON=/usr/bin/python3

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
