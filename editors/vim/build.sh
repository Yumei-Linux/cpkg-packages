#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package vim

FILENAME="vim-9.0.1273"

tar -xvf "./$FILENAME.tar.xz"

pushd $FILENAME
  echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
  echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h

  ./configure \
    --prefix=/usr \
    --with-features=huge \
    --enable-gui=gtk3 \
    --with-tlib=ncursesw

  make && make install

  ln -snfv ../vim/vim90/doc /usr/share/doc/vim-9.0.1273

  rsync -avzcP --exclude="/dos/" --exclude="/spell/" \
    ftp.nluug.nl::Vim/runtime/ ./runtime/

  make -C src installruntime
  vim -c ":helptags /usr/share/doc/vim-9.0.1273" -c ":q"
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.bz2"
