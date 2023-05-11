#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package gnutls

FILENAME="gnutls-3.8.0"

tar -xvf "./${FILENAME}.tar.xz"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/gnutls-3.8.0 \
    --with-default-trust-store-pkcs11="pkcs11:"

  make && make install
popd

rm -rf "./$FILENAME.tar.xz" "./$FILENAME"
