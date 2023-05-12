#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package tree

FILENAME="tree-2.1.0"

tar -xvf "./${FILENAME}.tgz"

pushd $FILENAME
  make
  make PREFIX=/usr MANDIR=/usr/share/man install
  chmod -v 644 /usr/share/man/man1/tree.1
popd

rm -rf "./$FILENAME.tgz" "./$FILENAME"
