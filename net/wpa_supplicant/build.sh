#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package wpa_supplicant

FILENAME="wpa_supplicant-2.10"

tar -xvf "./$FILENAME.tar.gz"

# creates the initial configuration file for the wpa-supplicant package.
function initial_config_file() {
echo "[*] Creating the initial configuration file for the wpa_supplicant pkg."
cat > wpa_supplicant/.config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=y
CONFIG_DEBUG_SYSLOG=y
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=y
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
CONFIG_CTRL_IFACE_DBUS=y
CONFIG_CTRL_IFACE_DBUS_NEW=y
CONFIG_CTRL_IFACE_DBUS_INTRO=y
EOF
}

pushd $FILENAME
  initial_config_file

  cd wpa_supplicant
  make BINDIR=/usr/sbin LIBDIR=/usr/lib

  install -v -m755 wpa_{cli,passphrase,supplicant} /usr/sbin/ &&
  install -v -m644 doc/docbook/wpa_supplicant.conf.5 /usr/share/man/man5/ &&
  install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 /usr/share/man/man8/

  install -v -m644 systemd/*.service /usr/lib/systemd/system/

  install -v -m644 dbus/fi.w1.wpa_supplicant1.service \
    /usr/share/dbus-1/system-services/

  install -v -d -m755 /etc/dbus-1/system.d

  install -v -m644 dbus/dbus-wpa_supplicant.conf \
    /etc/dbus-1/system.d/wpa_supplicant.conf

  echo "[*] Enabling the wpa supplicant service by using systemctl"
  echo "# systemctl enable wpa_supplicant"

  systemctl enable wpa_supplicant
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz"
