#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package linux-pam

FILENAME="Linux-PAM-1.5.3"
DOCFILE="${FILENAME}-docs"

tar -xvf "./${FILENAME}.tar.xz"

configure_pam () {
install -vdm755 /etc/pam.d
cat > /etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok

# End /etc/pam.d/other
EOF
cat > /etc/pam.d/system-account << "EOF" &&
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF

cat > /etc/pam.d/system-auth << "EOF" &&
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF

cat > /etc/pam.d/system-session << "EOF" &&
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF

cat > /etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# use sha512 hash for encryption, use shadow, and try to use any previously
# defined authentication token (chosen password) set by any prior module.
# Use the same number of rounds as shadow.
password  required    pam_unix.so       sha512 shadow try_first_pass \
                                        rounds=500000

# End /etc/pam.d/system-password
EOF
}

pushd $FILENAME
  tar -xvf "../${DOCFILE}.tar.xz" --strip-components=1

  sed -e 's/dummy elinks/dummy lynx/' \
      -e 's/-no-numbering -no-references/-force-html -nonumbers -stdin/' \
      -i configure

  ./configure \
    --prefix=/usr \
    --sbindir=/usr/sbin \
    --sysconfdir=/etc \
    --libdir=/usr/lib \
    --enable-securedir=/usr/lib/security \
    --docdir=/usr/share/doc/Linux-PAM-1.5.3

  make && make install

  echo "[Info] Configuring pam..."
  configure_pam

  chmod -v 4755 /usr/sbin/unix_chkpwd
popd

rm -rf "./$FILENAME.tar.xz" "./$FILENAME"
rm -rf "./$DOCFILE.tar.xz"
