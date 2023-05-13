#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package dbus

FILENAME="dbus-1.14.6"

tar -xvf "./$FILENAME.tar.xz"

# configuration step for the dbus package.
function configuration() {
cat > /etc/dbus-1/session-local.conf << "EOF"
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
EOF

echo "** Add dbus-launch to the line in the ~/.xinitrc file that starts your graphical desktop environment. **"
}

pushd $FILENAME
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --runstatedir=/run \
    --disable-doxygen-docs \
    --disable-xml-docs \
    --disable-static \
    --docdir=/usr/share/doc/dbus-1.14.6 \
    --with-system-socket=/run/dbus/system_bus_socket

  make && make install

  chown -v root:messagebus /usr/libexec/dbus-daemon-launch-helper
  chmod -v 4750 /usr/libexec/dbus-daemon-launch-helper

  echo "[*] Configuring dbus"
  configuration
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
