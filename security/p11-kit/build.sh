#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package p11-kit

FILENAME="p11-kit-0.24.1"

tar -xvf "./${FILENAME}.tar.xz"

function prepare() {
sed '20,$ d' -i trust/trust-extract-compat &&
cat >> trust/trust-extract-compat << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Update trust stores
/usr/sbin/make-ca -r
EOF
}

pushd $FILENAME
  prepare

  mkdir -pv p11-build
  cd p11-build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dtrust_paths=/etc/pki/anchors

  ninja && ninja install

  ln -svf /usr/libexec/p11-kit/trust-extract-compat \
          /usr/bin/update-ca-certificate
popd

rm -rf "./$FILENAME.tar.xz" "./$FILENAME"
