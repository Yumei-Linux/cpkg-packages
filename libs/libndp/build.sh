#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libndp

FILENAME="libndp-1.8"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
