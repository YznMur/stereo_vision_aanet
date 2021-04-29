#!/bin/bash
docker exec -it aanet \
    /bin/bash -c "source /opt/ros/noetic/setup.bash;
    cd /home/docker_aanet/catkin_ws;
    /bin/bash"

