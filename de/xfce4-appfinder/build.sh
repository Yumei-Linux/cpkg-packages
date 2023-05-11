#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package xfce4-appfinder

FILENAME="xfce4-appfinder-4.18.0"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  ./configure --prefix=/usr
  make && make install
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
