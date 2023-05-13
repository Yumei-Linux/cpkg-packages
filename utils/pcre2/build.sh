#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package pcre2

FILENAME="pcre2-10.42"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  ./configure --prefix=/usr \
    --docdir=/usr/share/doc/pcre2-10.42 \
    --enable-unicode \
    --enable-jit \
    --enable-pcre2-16 \
    --enable-pcre2-32 \
    --enable-pcre2grep-libz \
    --enable-pcre2grep-libbz2 \
    --enable-pcre2test-libreadline \
    --disable-static

  make && make install
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
