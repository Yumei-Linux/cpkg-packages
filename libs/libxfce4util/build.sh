#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package libxfce4util

tar -xvf ./libxfce4util-4.18.1.tar.bz2
cd libxfce4util-4.18.1

./configure --prefix=/usr

make
make install
