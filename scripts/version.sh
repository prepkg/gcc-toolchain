#!/bin/bash

cd build

TOOLCHAINS=(
  'x86_64-linux-gnu'
  'x86_64-linux-musl'
  'aarch64-linux-gnu'
  'aarch64-linux-musl'
  'arm-linux-gnueabi'
  'riscv64-linux-gnu'
)

for toolchain in "${TOOLCHAINS[@]}"; do
  tar xf gcc-$toolchain.tar.gz

  GCC=$toolchain/bin/$toolchain-gcc
  GCC_VERSION=$($GCC -dumpfullversion)
  if [[ $toolchain == *gnu* ]]; then
    LIBC_NAME=glibc
    LIBC_VERSION=$(strings $($GCC -print-file-name=libc.so.6) | grep GLIBC | sed 's/.*GLIBC_\([.0-9]*\).*/\1/g' | sort -Vu | tail -n1)
  else
    LIBC_NAME=musl
    LIBC_VERSION=$(strings $($GCC -print-sysroot)/lib/ld-musl-*.so.1 | grep -Po '1\.[0-9]+\.[0-9]+$')
  fi
  BINUTILS_VERSION=$($toolchain/bin/$toolchain-ld --version | head -n1 | grep -Po '[0-9.]+$')
  GDB_VERSION=$($toolchain/bin/$toolchain-gdb --version | head -n1 | grep -Po '[0-9.]+$')

  printf '* %s:\n\n' $toolchain
  printf '| %-9s | %-7s |\n' 'Component' 'Version'
  printf '|:----------|:--------|\n'
  printf '| %-9s | %-7s |\n' 'GCC' $GCC_VERSION
  printf '| %-9s | %-7s |\n' $LIBC_NAME $LIBC_VERSION
  printf '| %-9s | %-7s |\n' 'Binutils' $BINUTILS_VERSION
  printf '| %-9s | %-7s |\n\n' 'GDB' $GDB_VERSION

  rm -rf $toolchain
done
