#!/bin/bash
set -eo pipefail

cd /tmp
git clone https://github.com/crosstool-ng/crosstool-ng
cd crosstool-ng
git checkout 27cd838

./bootstrap
./configure --enable-local
make -j$(nproc)

mkdir -p /app/build /tmp/tarballs

TOOLCHAINS=(
  'x86_64-linux-gnu'
  'x86_64-linux-musl'
  'aarch64-linux-gnu'
  'aarch64-linux-musl'
  'arm-linux-gnueabi'
  'riscv64-linux-gnu'
)

for toolchain in "${TOOLCHAINS[@]}"; do
  cd /tmp/crosstool-ng
  mkdir samples/$toolchain
  cp /app/config/$toolchain.config samples/$toolchain/crosstool.config
  ./ct-ng $toolchain

  CT_PREFIX=/opt ./ct-ng build.$(nproc)
  cd /opt && tar czf /app/build/gcc-$toolchain.tar.gz $toolchain
done
