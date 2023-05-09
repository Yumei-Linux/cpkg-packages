#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package dash

tar -xvf ./dash-0.5.12.tar.gz
cd dash-0.5.12

./configure \
  --bindir=/bin \
  --mandir=/usr/share/man

make
make install
