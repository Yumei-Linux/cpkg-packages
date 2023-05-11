#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libxfce4ui

tar -xvf ./libxfce4ui-4.18.3.tar.bz2

pushd libxfce4ui-4.18.3
  ./configure --prefix=/usr
  make
  make install
popd

rm -rf ./libxfce4ui-4.18.3 ./libxfce4ui-4.18.3.tar.bz2
