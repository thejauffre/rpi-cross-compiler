#!/bin/bash
export XTOOLS=aarch64-rpi3-linux-gnu
export XTOOLS_PATH=~/opt
mkdir -p $XTOOLS_PATH
tar xJf x-tools-aarch64-rpi3-linux-gnu.tar.xz -C $XTOOLS_PATH
