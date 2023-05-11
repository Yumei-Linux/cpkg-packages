#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libpsl

FILENAME="libpsl-0.21.2"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  sed -i 's/env python/&3/' src/psl-make-dafsa

  ./configure \
    --prefix=/usr \
    --disable-static \
    PYTHON=python3

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
