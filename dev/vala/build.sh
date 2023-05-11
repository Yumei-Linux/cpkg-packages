#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package vala

FILENAME="vala-0.56.7"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure --prefix=/usr
  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
