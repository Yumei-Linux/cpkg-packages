#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package xfce4-settings

FILENAME="xfce4-screenshooter-1.9.7"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  ./configure --prefix=/usr
  make && make install
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
