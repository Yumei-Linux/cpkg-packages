#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package curl

FILENAME="curl-8.0.1"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --disable-static \
    --with-openssl \
    --enable-threaded-resolver \
    --with-ca-path=/etc/ssl/certs

  make && make install

  rm -rvf ./docs/examples/.deps

  find docs \( -name Makefile\* -o -name \*.1 -o -name \*.3 \) -exec rm {} \; &&

  install -v -d -m755 /usr/share/doc/curl-8.0.1 &&
  cp -v -R docs/*     /usr/share/doc/curl-8.0.1
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
