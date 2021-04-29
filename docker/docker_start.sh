#!/bin/bash

cd "$(dirname "$0")"
cd ..

workspace_dir=$PWD

if [ "$(docker ps -aq -f status=exited -f name=aanet)" ]; then
    docker rm aanet;
fi

docker run -it -d --rm \
    --gpus  all  \
    --net host \
    -e "NVIDIA_DRIVER_CAPABILITIES=all" \
    -e "DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    --shm-size="45g" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --name aanet \
    -v $workspace_dir/:/home/docker_aanet/catkin_ws/src/aanet_ros_node:rw \
    x64/aanet:latest
