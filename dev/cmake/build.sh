#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package cmake

FILENAME="cmake-3.26.3"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake

  ./bootstrap \
    --prefix=/usr \
    --system-libs \
    --mandir=/share/man \
    --no-system-jsoncpp \
    --no-system-librhash \
    --docdir=/share/doc/cmake-3.26.3

  make && make install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
