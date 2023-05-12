#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package doxygen

FILENAME="doxygen-1.9.6.src"

tar -xvf "./${FILENAME}.tar.gz"

pushd $FILENAME
  mkdir -pv build
  cd build

  cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -Wno-dev ..

  make && make install

  install -vm644 ../doc/*.1 /usr/share/man/man1
popd

rm -rf "./$FILENAME.tar.gz" "./$FILENAME"
