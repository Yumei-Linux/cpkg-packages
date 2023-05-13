#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package wget

FILENAME="wget-1.18"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure --prefix=/usr \
    --sysconfdir=/etc

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
