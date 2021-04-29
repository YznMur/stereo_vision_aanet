FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04

#install required libs and packages
RUN apt-get update && apt-get install -y --no-install-recommends wget build-essential git curl ca-certificates libjpeg-dev libpng-dev python3-pip \
	lsb-release ninja-build

ENV FORCE_CUDA="1"

# ROS Noetic installation
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
	&& apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
	&& apt update && apt install -y ros-noetic-desktop


# Update pip & install pytorch
RUN python3 -m pip install pip --upgrade
RUN python3 -m pip install wheel
RUN pip install pyyaml numpy ipython
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN pip install torch==1.7.0+cu110 torchvision==0.8.1+cu110 -f https://download.pytorch.org/whl/torch_stable.html

# CMake installation
RUN wget -q https://github.com/Kitware/CMake/releases/download/v3.16.4/cmake-3.16.4-Linux-x86_64.tar.gz
RUN tar -xzf cmake-3.16.4-Linux-x86_64.tar.gz --exclude=bin/cmake-gui --exclude=doc/cmake --exclude=share/cmake-3.12/Help  \
	&& cp -fR cmake-3.16.4-Linux-x86_64/* /usr  \
	&& rm -rf cmake-3.16.4-Linux-x86_64  \
	&& rm cmake-3.16.4-Linux-x86_64.tar.gz


# installing ROS and centerpoint packages
RUN	pip install rospkg scikit-image scipy numba  fire protobuf opencv-python opencv-contrib-python    \
	easydict open3d-python  pytest-runner addict pycocotools imagecorruptions cachetools descartes \
	Pillow  scikit-learn Shapely  requests empy rosdep filterpy



ARG USER=docker_aanet
ARG UID=1000
ARG GID=1000
# default password
ARG PW=user 

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | chpasswd && adduser ${USER} sudo

WORKDIR /home/${USER}
RUN cd /home/${USER} && mkdir -p catkin_ws/src && chown -R ${UID}:${GID} ./

USER ${UID}:${GID}
