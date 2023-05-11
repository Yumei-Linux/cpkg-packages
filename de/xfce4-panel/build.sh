#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package xfce4-panel

FILENAME="xfce4-panel-4.18.3"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc

  make
  make install
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
