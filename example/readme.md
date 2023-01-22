## Working example

First, source the file with required environment variables:
```
source ../scripts/set_env.sh
```
then:
```
mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=Toolchain-RaspberryPi.cmake ..
make
```

Done.