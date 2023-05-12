#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package fish

FILENAME="fish-3.6.1"

tar -xvf "./$FILENAME.tar.xz"

function configure() {
cat >> /etc/shells << EOF
/usr/bin/fish
EOF
}

pushd "$FILENAME"
  mkdir build; cd build
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr
  make
  make install
  configure
popd

rm -rf "./$FILENAME" "./$FILENAME.tar.xz"
