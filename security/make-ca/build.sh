#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package make-ca

FILENAME="make-ca-1.12"

tar -xvf "./${FILENAME}.tar.xz"

function configuring() {
  echo "[*] Running make-ca configuration script"
  /usr/sbin/make-ca -g
  echo "[I] Enabling unit update-pki.timer through systemctl"
  echo "# systemctl enable update-pki.timer"
  systemctl enable update-pki.timer
}

pushd $FILENAME
  make install
  install -vdm755 /etc/ssl/local
  configuring
popd

rm -rf "./$FILENAME.tar.xz" "./$FILENAME"
