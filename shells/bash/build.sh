#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package bash

FILENAME="bash-5.2.15"

tar -xvf "./$FILENAME.tar.gz"

function configure() {
echo "[*] Appending bash into /etc/shells"
cat >> /etc/shells << EOF
/bin/bash
/usr/bin/bash
EOF
}

pushd "$FILENAME"
  ./configure \
    --prefix=/usr \
    --without-bash-malloc \
    --docdir=/usr/share/doc/bash-5.2.15

  make && make install

  configure
popd

rm -rf "./$FILENAME" "./$FILENAME.tar.gz"
