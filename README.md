# GCC Toolchain

GCC toolchain targeting **older glibc versions**, designed for building Linux binaries that run across a wide range of
distributions. Intended for use inside a Docker container running **Ubuntu 24.04 or later**. This toolchain is built
using [Crosstool-NG](https://github.com/crosstool-ng/crosstool-ng).

## Why?

The usual method for producing portable Linux binaries is to compile them on an outdated distribution (e.g., CentOS 7).

This repository provides a **modern alternative**: a GCC toolchain configured to target an older glibc, ensuring
compatibility and preventing errors like:

```text
/lib64/libc.so.6: version `GLIBC_2.XX' not found
```

## Supported Toolchains

* x86_64-linux-gnu:

| Component  | Version  |
|:-----------|:---------|
| GCC        | 15.2.0   |
| glibc      | 2.17     |
| Binutils   | 2.45     |
| GDB        | 16.3     |

* aarch64-linux-gnu:

| Component  | Version  |
|:-----------|:---------|
| GCC        | 15.2.0   |
| glibc      | 2.17     |
| Binutils   | 2.29.1   |
| GDB        | 16.3     |

## Precompiled Toolchains

If you prefer not to build the toolchain yourself, a precompiled GCC toolchain for each supported architecture can be
downloaded from the [releases page](https://github.com/prepkg/gcc-toolchain/releases).

* x86_64-linux-gnu:

```shell
curl -sSLo gcc-x86_64-linux-gnu.tar.gz https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-x86_64-linux-gnu.tar.gz
```

* aarch64-linux-gnu:

```shell
curl -sSLo gcc-aarch64-linux-gnu.tar.gz https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-aarch64-linux-gnu.tar.gz
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

* Build the GCC toolchain:

```shell
./setup.sh build-toolchain
```

* (Optional) Check the toolchain component versions:

```shell
./setup.sh version
```

After compilation, the toolchains for each architecture will be available in the `build` directory.
