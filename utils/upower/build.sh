#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package upower

FILENAME="upower-v1.90.0"

tar -xvf "./${FILENAME}.tar.bz2"

pushd $FILENAME
  sed '/parse_version/d' -i src/linux/integration-test.py

  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dgtk-doc=false \
    -Dman=false

  ninja && ninja install

  echo "[Info] Enabling upower systemd service at boot through systemctl"
  echo "# systemctl enable upower"

  systemctl enable upower
popd

rm -rf "./$FILENAME.tar.bz2" "./$FILENAME"
