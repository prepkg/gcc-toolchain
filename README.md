# GCC Toolchain

GCC toolchain targeting **older glibc versions**, designed for building Linux binaries that run across a wide range of
distributions. This toolchain is intended for use inside a Docker container running **Ubuntu 24.04 or later**.

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
