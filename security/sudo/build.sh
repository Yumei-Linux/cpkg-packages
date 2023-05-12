#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package sudo

FILENAME="sudo-1.9.13p3"

tar -xvf "./${FILENAME}.tar.gz"

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --libexecdir=/usr/lib \
    --with-secure-path \
    --with-all-insults \
    --with-env-editor \
    --docdir=/usr/share/doc/sudo-1.9.13p3 \
    --with-passprompt="Passwd For %p: "

  make && make install

  ln -sfv libsudo_util.so.0.0.0 /usr/lib/sudo/libsudo_util.so.0
popd

rm -rf "./$FILENAME.tar.gz" "./$FILENAME"
