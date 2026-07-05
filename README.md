# GCC Toolchain

[![GitHub Release](https://img.shields.io/github/v/release/prepkg/gcc-toolchain)](https://github.com/prepkg/gcc-toolchain/releases/latest)
[![License](https://img.shields.io/github/license/prepkg/gcc-toolchain)](https://github.com/prepkg/gcc-toolchain/blob/master/LICENSE)
[![Downloads](https://img.shields.io/github/downloads/prepkg/gcc-toolchain/total)](https://github.com/prepkg/gcc-toolchain/releases)

> ⭐ If you find this repository useful, please consider giving it a star.

GCC **cross-compiler** toolchain targeting **older glibc versions** and **musl**, designed for **cross-compilation** of
portable Linux binaries across a wide range of distributions. Intended for use inside a Docker container running
**Ubuntu 26.04 or later**. This toolchain is built using [Crosstool-NG](https://github.com/crosstool-ng/crosstool-ng).

To get started, [download a precompiled toolchain](#precompiled-toolchains) or [build from source](#compilation).

## Why?

The usual method for producing portable Linux binaries is to compile them on an outdated distribution (e.g., CentOS 7).

This repository provides a **modern alternative**:

* **glibc targets** - a GCC toolchain configured to target an older glibc, ensuring compatibility and preventing errors like:

```text
/lib64/libc.so.6: version `GLIBC_2.XX' not found
```

* **musl targets** - produce fully static binaries with no dynamic library dependencies, maximizing portability.

## Supported Toolchains

| Target             | GCC    | C Library  | Binutils | GDB  |
|:-------------------|:-------|:-----------|:---------|:-----|
| x86_64-linux-gnu   | 16.1.0 | glibc 2.17 | 2.46.1   | 17.2 |
| x86_64-linux-musl  | 16.1.0 | musl 1.2.6 | 2.46.1   | 17.2 |
| aarch64-linux-gnu  | 16.1.0 | glibc 2.26 | 2.46.1   | 17.2 |
| aarch64-linux-musl | 16.1.0 | musl 1.2.6 | 2.46.1   | 17.2 |
| arm-linux-gnueabi  | 16.1.0 | glibc 2.26 | 2.46.1   | 17.2 |
| riscv64-linux-gnu  | 16.1.0 | glibc 2.30 | 2.46.1   | 17.2 |

## Precompiled Toolchains

If you prefer not to build the toolchain yourself, a precompiled GCC toolchain for each supported architecture can be
downloaded from the [releases page](https://github.com/prepkg/gcc-toolchain/releases).

Replace `<target>` with one of: `x86_64-linux-gnu`, `x86_64-linux-musl`, `aarch64-linux-gnu`, `aarch64-linux-musl`,
`arm-linux-gnueabi`, `riscv64-linux-gnu`.

```shell
curl -sSLo gcc-<target>.tar.gz https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-<target>.tar.gz
```

For example:

```shell
curl -sSLo gcc-x86_64-linux-gnu.tar.gz https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-x86_64-linux-gnu.tar.gz
```

## Compilation

* Clone the repository:

```shell
git clone https://github.com/prepkg/gcc-toolchain.git && cd gcc-toolchain
```

* Build the Docker image:

```shell
./setup.sh build-image
```

* Build the GCC toolchain (all targets):

```shell
./setup.sh build-toolchain
```

After compilation, the toolchains for each architecture will be available in the `build` directory.

* (Optional) Check the toolchain component versions:

```shell
./setup.sh version
```
