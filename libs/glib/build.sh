#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package glib

FILENAME="glib-2.76.2"
PATCH="${FILENAME}-skip_warnings-1.patch"

tar -xvf "./$FILENAME.tar.xz"

# build phase
pushd $FILENAME
  patch -Np1 -i "../${PATCH}"

  if [ -e /usr/include/glib-2.0 ]; then
    echo "[*] Previous version of glib detected, moving headers to let the package update itself"
    rm -rf /usr/include/glib-2.0.old &&
    mv -vf /usr/include/glib-2.0{,.old}
  fi

  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dman=false

  ninja && ninja install
popd

# cleaning.
rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz" \
  "./${PATCH}"
