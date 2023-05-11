#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package thunar

FILENAME="thunar-4.18.6"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --docdir=/usr/share/doc/thunar-4.18.6

  make && make install
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
