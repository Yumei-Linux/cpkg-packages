#!/usr/bin/env bash

# This script is part of the cpkg project
# This script builds the package nss

FILENAME="nss-3.89.1"
PATCH_FILENAME="${FILENAME}-standalone-1"

tar -xvf "./$FILENAME.tar.gz"

pushd $FILENAME
  patch -Np1 -i "../${PATCH_FILENAME}.patch"

  cd nss

  make BUILD_OPT=1                  \
    NSPR_INCLUDE_DIR=/usr/include/nspr  \
    USE_SYSTEM_ZLIB=1                   \
    ZLIB_LIBS=-lz                       \
    NSS_ENABLE_WERROR=0                 \
    $([ $(uname -m) = x86_64 ] && echo USE_64=1) \
    $([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1)

  cd ../dist

  install -v -m755 Linux*/lib/*.so              /usr/lib              
  install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib              

  install -v -m755 -d                           /usr/include/nss      
  cp -v -RL {public,private}/nss/*              /usr/include/nss      

  install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin 

  install -v -m644 Linux*/lib/pkgconfig/nss.pc  /usr/lib/pkgconfig

  # using p11-kit trust module as a drop-in replacement for /usr/lib/libnssckbi.so
  ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so
popd

rm -rf "./${FILENAME}" "./${FILENAME}.tar.gz" \
  "./${PATCH_FILENAME}"
