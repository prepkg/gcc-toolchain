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

printf '| %-18s | %-6s | %-10s | %-8s | %-4s |\n' 'Target' 'GCC' 'C Library' 'Binutils' 'GDB'
printf '|:-------------------|:-------|:-----------|:---------|:-----|\n'

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

  printf '| %-18s | %-6s | %-10s | %-8s | %-4s |\n' \
    $toolchain $GCC_VERSION "$LIBC_NAME $LIBC_VERSION" $BINUTILS_VERSION $GDB_VERSION

  rm -rf $toolchain
done
