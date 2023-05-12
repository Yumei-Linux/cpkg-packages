#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package zsh

FILENAME="zsh-5.9"
DOCNAME="zsh-5.9-doc"

tar -xvf "./$FILENAME.tar.xz"

function configure() {
cat >> /etc/shells << EOF
/bin/zsh
EOF
}

pushd "$FILENAME"
  tar --strip-components=1 -xvf "../$DOCNAME.tar.xz"

  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc/zsh \
    --enable-etcdir=/etc/zsh \
    --enable-cap \
    --enable-gdbm

  make

  makeinfo Doc/zsh.texi --plaintext -o Doc/zsh.txt
  makeinfo Doc/zsh.texi --html -o Doc/html
  makeinfo Doc/zsh.texi --html --no-split --no-headers -o Doc/zsh.html

  make install
  make infodir=/usr/share/info install.info

  install -v -m755 -d /usr/share/doc/zsh-5.9/html
  install -v -m644 Doc/html/* /usr/share/doc/zsh-5.9/html
  install -v -m644 Doc/zsh.{html,txt} /usr/share/doc/zsh-5.9

  make htmldir=/usr/share/doc/zsh-5.9/html install.html
  install -v -m644 Doc/zsh.dvi /usr/share/doc/zsh-5.9

  configure
popd

rm -rf "./$FILENAME" "./$FILENAME.tar.xz"
rm -rf "./$DOCNAME.tar.xz"
