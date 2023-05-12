#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package pcre

FILENAME="pcre-8.45"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/pcre-8.45 \
    --enable-unicode-properties \
    --enable-pcre16 \
    --enable-pcre32 \
    --enable-pcregrep-libz \
    --enable-pcregrep-libbz2 \
    --enable-pcretest-libreadline \
    --disable-static

  make && make install
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
