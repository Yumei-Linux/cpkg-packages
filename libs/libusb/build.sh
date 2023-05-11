#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libusb

FILENAME="libusb-1.0.26"

tar -xvf "./$FILENAME.tar.bz2"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --disable-static

  make

  pushd doc
    doxygen -u doxygen.cfg
    make docs
  popd

  make install

  install -v -d -m755 /usr/share/doc/libusb-1.0.26/apidocs
  install -v -m644 doc/api-1.0/* /usr/share/doc/libusb-1.0.26/apidocs
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.bz2"
