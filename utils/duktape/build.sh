#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package duktape

FILENAME="duktape-2.7.0"

tar -xvf "./${FILENAME}.tar.xz"

pushd $FILENAME
  sed -i 's/-Os/-O2/' Makefile.sharedlibrary
  make -f Makefile.sharedlibrary INSTALL_PREFIX=/usr
  make -f Makefile.sharedlibrary INSTAPP_PREFIX=/usr install
popd

rm -rf "./$FILENAME.tar.xz" "./$FILENAME"
