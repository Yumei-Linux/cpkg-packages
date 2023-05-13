#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package nspr

FILENAME="nspr-4.35"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  cd nspr

  sed -ri '/^RELEASE/s/^/#/' pr/src/misc/Makefile.in
  sed -i 's#$(LIBRARY) ##'   config/rules.mk

  ./configure --prefix=/usr \
    --with-mozilla \
    --with-pthreads \
    $([ $(uname -m) = x86_64 ] && echo --enable-64bit)

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
