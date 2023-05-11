#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package graphviz

FILENAME="graphviz-8.0.5"

tar -xvf "./$FILENAME.tar.bz2"

pushd $FILENAME
  sed -i '/LIBPOSTFIX="64"/s/64//' configure.ac

  ./autogen.sh

  ./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/graphviz-8.0.5

  sed -i "s/0/$(date +%Y%m%d)/" builddate.h

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.bz2"
