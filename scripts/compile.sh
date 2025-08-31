#!/bin/bash

cd /tmp
git clone https://github.com/crosstool-ng/crosstool-ng
cd crosstool-ng
git checkout 7f9d704

./bootstrap
./configure --enable-local
make -j$(nproc)

mkdir -p /app/build

TOOLCHAINS=(
  'x86_64-linux-gnu'
  'aarch64-linux-gnu'
)

for toolchain in "${TOOLCHAINS[@]}"; do
  cd /tmp/crosstool-ng
  mkdir samples/$toolchain
  cp /app/config/$toolchain.config samples/$toolchain/crosstool.config
  ./ct-ng $toolchain

  CT_PREFIX=/opt ./ct-ng build.$(nproc)
  cd /opt && tar czf /app/build/gcc-$toolchain.tar.gz $toolchain
done
