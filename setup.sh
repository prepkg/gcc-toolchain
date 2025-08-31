#!/bin/bash

if [[ ! $1 =~ ^(build-image|build-toolchain|version)$ ]]; then
  echo 'Available arguments: build-image, build-toolchain, version'
  exit 1
fi

if [[ $1 == build-image ]]; then
  docker build -t gcc-toolchain scripts

  exit 0
fi

if [[ $1 == build-toolchain ]]; then
  docker run -it --rm -v ./:/app gcc-toolchain scripts/compile.sh
  sudo chown -R $USER:$USER build

  exit 0
fi

if [[ $1 == version ]]; then
  docker run -it --rm -v ./:/app gcc-toolchain scripts/version.sh

  exit 0
fi
