#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package openssl

FILENAME="openssl-1.0.2h"

tar -xvf "./${FILENAME}.tar.gz"

pushd $FILENAME
  ./config --prefix=/usr \
    --openssldir=/etc/ssl \
    --libdir=lib \
    shared \
    zlib-dynamic

  make depend && make

  make MANDIR=/usr/share/man MANSUFFIX=ssl install
  install -dv -m755 /usr/share/doc/openssl-1.0.2h
  cp -vfr doc/* /usr/share/doc/openssl-1.0.2h
popd

rm -rf "./$FILENAME.tar.gz" "./$FILENAME"
