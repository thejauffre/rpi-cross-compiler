#!/bin/bash
 
container=$(docker run -d thejauffre/rpicross:v1 bash -c "tar cJf ~/x-tools.tar.xz aarch64-rpi3-linux-gnu")
docker wait $container
docker cp $container:/home/appuser/x-tools.tar.xz x-tools-aarch64-rpi3-linux-gnu.tar.xz
docker rm $container