#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libedit

FILENAME="libedit-20221030-3.1"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  ./configure --prefix=/usr
  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
