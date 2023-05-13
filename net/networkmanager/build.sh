#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package networkmanager

FILENAME="NetworkManager-1.42.6"

tar -xvf "./$FILENAME.tar.xz"

# configuration step for network manager
function configuration() {
cat >> /etc/NetworkManager/NetworkManager.conf << "EOF"
[main]
plugins=keyfile
EOF

cat > /etc/NetworkManager/conf.d/polkit.conf << "EOF"
[main]
auth-polkit=true
EOF

cat > /etc/NetworkManager/conf.d/dhcp.conf << "EOF"
[main]
dhcp=dhclient
EOF

groupadd -fg 86 netdev 

echo "[*] Including your user into the netdev group required for network manager"
printf "> Write your username (keep blank to skip): "
read username

if [[ $username != "" ]]; then
  /usr/sbin/usermod -a -G netdev "$username"
fi

cat > /usr/share/polkit-1/rules.d/org.freedesktop.NetworkManager.rules << "EOF"
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("netdev")) {
        return polkit.Result.YES;
    }
});
EOF

echo "[*] Done, now activating network manager systemd units through systemctl"
echo "# systemctl enable NetworkManager"
echo "# systemctl disable NetworkManager-wait-online"

systemctl enable NetworkManager
systemctl disable NetworkManager-wait-online
}

pushd $FILENAME
  echo "[*] Making network manager python scripts use python3"
  grep -rl '^#!.*python$' | xargs sed -i '1s/python/&3/'

  echo "[*] Building network manager"
  mkdir -pv build && cd build

  CXXFLAGS+="-O2 -fPIC"

  meson setup ..               \
    --prefix=/usr              \
    --buildtype=release        \
    -Dlibaudit=no              \
    -Dlibpsl=false             \
    -Dnmtui=true               \
    -Dovs=false                \
    -Dppp=false                \
    -Dselinux=false            \
    -Dqt=false                 \
    -Dsession_tracking=systemd \
    -Dmodem_manager=false

  ninja && ninja install

  echo "[*] Installing network manager docs"
  mv -v /usr/share/doc/NetworkManager{,-1.42.6}
  cp -Rv ../docs/{api,libnm} /usr/share/doc/NetworkManager-1.42.6

  echo "[*] Configuring network manager"
  configuration
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.xz"
