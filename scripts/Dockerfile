FROM ubuntu:24.04

WORKDIR /app

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        wget ca-certificates git gcc g++ make automake libtool-bin flex bison texinfo bzip2 xz-utils unzip help2man \
        file patch gawk libncurses-dev python3-dev \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
