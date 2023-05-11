#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package polkit

FILENAME="polkit-122"

tar -xvf "./${FILENAME}.tar.gz"

pushd $FILENAME
  groupadd -fg 27 polkitd
  useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 \
    -g polkitd -s /bin/false polkitd

  mkdir -pv build
  cd build

  meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -Dman=false \
    -Dsession_tracking=libsystemd-login \
    -Dtests=false

  ninja && ninja install
popd

rm -rf "./$FILENAME.tar.gz" "./$FILENAME"
