#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package git

FILENAME="git-2.40.1"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --with-gitconfig=/etc/gitconfig \
    --with-python=python3

  make && make perllibdir=/usr/lib/perl5/5.36/site_perl install
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
