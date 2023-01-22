FROM ubuntu:22.04

ARG CONFIG_FILE=aarch64-rpi3-linux-gnu

# Update packages and install some
RUN apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
    git wget build-essential cmake gcc g++ make libncurses5-dev python3-dev xz-utils bzip2 ca-certificates\
    bison cvs flex gperf texinfo automake libtool libtool-bin gawk rsync unzip help2man && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Add a user called `appuser` and add him to the sudo group
RUN useradd -m appuser && \
    echo "appuser:appuser" | chpasswd && \
    adduser appuser sudo

# Set toolchain version, final install path and temp download path
ENV CROSS_VERSION 1.25.0
ENV CROSS_PATH /opt/crosstool
ENV TEMP_PATH /RaspberryPi/crosstool

# Download toolchain source -- will be used to build the actual toolchain
RUN mkdir -p ${TEMP_PATH} && \
    cd ${TEMP_PATH} && \
    wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-${CROSS_VERSION}.tar.bz2 -O crosstool.tar.bz2 && \
    tar xjf crosstool.tar.bz2 && rm crosstool.tar.bz2

# Setup and install
RUN cd ${TEMP_PATH}/crosstool-ng-${CROSS_VERSION} && ./configure --prefix=${CROSS_PATH} && \
    make && make install && export PATH=$PATH:${CROSS_PATH}    

ENV PATH="${PATH}:${CROSS_PATH}/bin"

USER appuser
ENV STAGING_PATH=/home/appuser/RaspberryPi/staging
ENV TOOLCHAIN_PATH=/home/appuser/RaspberryPi/${CONFIG_FILE}
RUN mkdir -p ${STAGING_PATH}
WORKDIR ${STAGING_PATH}
COPY ${CONFIG_FILE}.config defconfig

# Build the cross compiler
RUN ct-ng defconfig
RUN V=1 ct-ng build || { cat build.log && false; } && rm -rf .build
ENV PATH=${TOOLCHAIN_PATH}/bin:$PATH