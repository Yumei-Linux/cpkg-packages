#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package dhcp

FILENAME="dhcp-4.4.3-P1"
UNIT_FILENAME="blfs-systemd-units-20220720"

tar -xvf "./$FILENAME.tar.gz"
tar -xvf "./${UNIT_FILENAME}.tar.xz"

# configuration phase for the dhcp package.
function configuration() {
echo "[*] Configuring dhclient"
install -vdm755 /etc/dhcp &&
cat > /etc/dhcp/dhclient.conf << "EOF"
# Begin /etc/dhcp/dhclient.conf
#
# Basic dhclient.conf(5)

#prepend domain-name-servers 127.0.0.1;
request subnet-mask, broadcast-address, time-offset, routers,
        domain-name, domain-name-servers, domain-search, host-name,
        netbios-name-servers, netbios-scope, interface-mtu,
        ntp-servers;
require subnet-mask, domain-name-servers;
#timeout 60;
#retry 60;
#reboot 10;
#select-timeout 5;
#initial-interval 2;

# End /etc/dhcp/dhclient.conf
EOF

install -v -dm 755 /var/lib/dhclient
systemctl disable systemd-networkd

echo "** You can enable the dhclient unit by running systemctl enable --now dhclient@<iface> **"

echo "[*] Configuring dhcpd"
cat > /etc/dhcp/dhcpd.conf << "EOF"
# Begin /etc/dhcp/dhcpd.conf
#
# Example dhcpd.conf(5)

# Use this to enable / disable dynamic dns updates globally.
ddns-update-style none;

# option definitions common to all supported networks...
option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

# This is a very basic subnet declaration.
subnet 10.254.239.0 netmask 255.255.255.224 {
  range 10.254.239.10 10.254.239.20;
  option routers rtr-239-0-1.example.org, rtr-239-0-2.example.org;
}

# End /etc/dhcp/dhcpd.conf
EOF

install -v -dm 755 /var/lib/dhcpd
touch /var/lib/dhcpd/dhcpd.leases

echo "** You'll need to edit the /etc/default/dhcpd in order to set the interface on which dhcpd will serve the DHCP requests! **"
echo "You can enable the dhcpd unit by running systemctl enable --now dhcpd"
}

pushd "blfs-systemd-units-20220720"
  echo "[*] Installing systemd unit for dhcp and dhcpd"

  make install-dhcp
  make install-dhcpd

  echo "[*] Units installing done"
popd

pushd $FILENAME
  ( export CFLAGS="${CFLAGS:--g -O2} -Wall -fno-strict-aliasing       \
          -D_PATH_DHCLIENT_SCRIPT='\"/usr/sbin/dhclient-script\"'     \
          -D_PATH_DHCPD_CONF='\"/etc/dhcp/dhcpd.conf\"'               \
          -D_PATH_DHCLIENT_CONF='\"/etc/dhcp/dhclient.conf\"'"        &&

  ./configure --prefix=/usr                                           \
              --sysconfdir=/etc/dhcp                                  \
              --localstatedir=/var                                    \
              --with-srv-lease-file=/var/lib/dhcpd/dhcpd.leases       \
              --with-srv6-lease-file=/var/lib/dhcpd/dhcpd6.leases     \
              --with-cli-lease-file=/var/lib/dhclient/dhclient.leases \
              --with-cli6-lease-file=/var/lib/dhclient/dhclient6.leases
  )

  make -j1 && make install

  install -v -m755 client/scripts/linux /usr/sbin/dhclient-script

  echo "[*] dhcp building done, configuring it..."
  configuration
popd

# cleaning up files
rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz" \
  "./${UNIT_FILENAME}" "./${UNIT_FILENAME}.tar.xz"
