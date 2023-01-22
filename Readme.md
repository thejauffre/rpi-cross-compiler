# Docker cross compiler tool

This repository contains a dockerfile, that can be used to create a Raspberry Pi cross-compiling toolchain.  

## How to build

Simply build the image with:
```
docker build --build-arg FINAL_ARCH=aarch64-rpi3-linux-gnu -t thejauffre/rpicross:v1 .
```

You can pass your custom config file by using the *FINAL_ARCH* argument. The one provided here was created (within an intermediate image) using
```
ct-ng menuconfig
```
as explained [here](https://www.kitware.com/cross-compiling-for-raspberry-pi/).

You can retrieve the toolchain as a tar file using the [get_tar](get_tar.sh) script.

### Installing on other systems

Simply untar the archive in your preferred location

```
mkdir -p ~/opt
tar xJf x-tools-aarch64-rpi3-linux-gnu.tar.xz -C ~/opt
```
then set the environment variables (according to the path you used)

```
export XTOOLS=aarch64-rpi3-linux-gnu
export XTOOLS_PATH=~/opt
```

finally you can use the [Toolchain-RaspberryPi.cmake](Toolchain-RaspberryPi.cmake) to build your project.

## References

https://tttapa.github.io/Pages/Raspberry-Pi/C++-Development/Building-The-Toolchain.html

https://www.kitware.com/cross-compiling-for-raspberry-pi/

https://www.bootc.net/archives/2012/05/26/how-to-build-a-cross-compiler-for-your-raspberry-pi/