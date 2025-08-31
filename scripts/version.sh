#!/bin/bash

cd build

TOOLCHAINS=(
  'x86_64-linux-gnu'
  'aarch64-linux-gnu'
)

for toolchain in "${TOOLCHAINS[@]}"; do
  tar xf gcc-$toolchain.tar.gz

  GCC_VERSION=$($toolchain/bin/$toolchain-gcc -dumpversion)
  GLIBC_VERSION=$(strings $toolchain/$toolchain/sysroot/lib/libc.so.6 | grep GLIBC | sed 's/.*GLIBC_\([.0-9]*\).*/\1/g' | sort -Vu | tail -n1)
  BINUTILS_VERSION=$($toolchain/bin/$toolchain-ld --version | head -n1 | grep -Po '[0-9.]+$')
  GDB_VERSION=$($toolchain/bin/$toolchain-gdb --version | head -n1 | grep -Po '[0-9.]+$')

  printf '* %s:\n\n' $toolchain
  printf '| %-10s | %-8s |\n' 'Component' 'Version'
  printf '|:-----------|:---------|\n'
  printf '| %-10s | %-8s |\n' 'GCC' $GCC_VERSION
  printf '| %-10s | %-8s |\n' 'glibc' $GLIBC_VERSION
  printf '| %-10s | %-8s |\n' 'Binutils' $BINUTILS_VERSION
  printf '| %-10s | %-8s |\n\n' 'GDB' $GDB_VERSION

  rm -rf $toolchain
done
