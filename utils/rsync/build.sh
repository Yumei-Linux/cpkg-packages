#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package rsync

FILENAME="rsync-3.2.7"

tar -xvf "./${FILENAME}.tar.gz"

pushd $FILENAME
  groupadd -g 48 rsyncd

  useradd -C "rsyncd Daemon" -m -d /home/rsync -g rsyncd \
    -s /bin/false -u 48 rsyncd

  ./configure \
    --prefix=/usr \
    --disable-lz4 \
    --disable-xxhash \
    --without-included-zlib

  make
  doxygen
  make install

  install -v -m755 -d /usr/share/doc/rsync-3.2.7/api
  install -v -m644 dox/html/* /usr/share/doc/rsync-3.2.7/api
popd

rm -rf "./$FILENAME.tar.gz" "./$FILENAME"
