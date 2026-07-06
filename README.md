# GCC Toolchain

[![GitHub Release](https://img.shields.io/github/v/release/prepkg/gcc-toolchain)](https://github.com/prepkg/gcc-toolchain/releases/latest)
[![License](https://img.shields.io/github/license/prepkg/gcc-toolchain)](https://github.com/prepkg/gcc-toolchain/blob/master/LICENSE)
[![Downloads](https://img.shields.io/github/downloads/prepkg/gcc-toolchain/total)](https://github.com/prepkg/gcc-toolchain/releases)
[![Changelog](https://img.shields.io/badge/changelog-Keep%20a%20Changelog-%23E05735)](CHANGELOG.md)

> 🚀️ GCC cross-compiler toolchain targeting older glibc versions and musl - just download and use it.

> ⭐ If you find this repository useful, please consider giving it a star.

The toolchain designed for **cross-compilation** of portable Linux binaries across a wide range of distributions.
Intended for use inside a Docker container running **Ubuntu 26.04 or later**. This toolchain is built
using [Crosstool-NG](https://github.com/crosstool-ng/crosstool-ng).

To get started, [download a precompiled toolchain](#precompiled-toolchains) or [build from source](#compilation).

## Why?

* **Modern alternative to old distros.** The usual method for producing portable Linux binaries is to compile them on an
  outdated distribution (e.g., CentOS 7). This toolchain lets you build on a modern system while targeting older
  environments.
* **glibc compatibility.** The toolchain is configured to target an older glibc, ensuring compatibility and preventing
  errors like: `/lib64/libc.so.6: version GLIBC_2.XX not found`.
* **musl for fully static binaries.** The toolchain provides musl targets that produce fully static binaries with no
  dynamic library dependencies, maximizing portability across any Linux system.
* **No build required.** The toolchain is ready to download and use immediately. Building GCC from source takes hours;
  this skips that entirely.

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

The command installs toolchain to `/opt`. Replace it with a different path if needed.

```shell
curl -sSL https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-<target>.tar.gz | sudo tar xz -C /opt
```

For example:

```shell
curl -sSL https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-x86_64-linux-gnu.tar.gz | sudo tar xz -C /opt
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
