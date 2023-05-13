#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package slang

FILENAME="slang-2.3.3"

tar -xvf "./$FILENAME.tar.bz2"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --with-readline=gnu

  make -j1

  make install_doc_dir=/usr/share/doc/slang-2.3.3 \
    SLSH_DOC_DIR=/usr/share/doc/slang-2.3.3/slsh \
    install

  chmod -v 755 /usr/lib/slang/v2/modules/*.so
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.bz2"
