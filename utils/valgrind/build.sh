#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package valgrind

FILENAME="valgrind-3.21.0"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  sed -i 's|/doc/valgrind||' docs/Makefile.in &&

  ./configure --prefix=/usr \
    --datadir=/usr/share/doc/valgrind-3.21.0

  make && make install
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
