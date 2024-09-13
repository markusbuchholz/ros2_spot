FROM osrf/ros:humble-desktop AS base

ARG USERNAME=ros2_spot
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

# Install a few handy tools
RUN apt-get update \
  && apt-get -y --quiet --no-install-recommends install \
    bash-completion \
    build-essential \
    git \
    glmark2 \
    gnupg \
    iputils-ping \
    lsb-release \
    mlocate \
    software-properties-common \
    sudo \
    wget \
    vim \
  && rm -rf /var/lib/apt/lists/*

# Install NVIDIA software
RUN apt-get update \
 && apt-get -y --quiet --no-install-recommends install \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
  && rm -rf /var/lib/apt/lists/*
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute
ENV QT_X11_NO_MITSHM=1


# install Gazebo Garden and other required packages
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
  && apt-get update \
  && apt-get -y --quiet --no-install-recommends install \
    libgz-sim7-dev \
    libopencv-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-libav \
    gstreamer1.0-gl \
    gz-garden \
  && rm -rf /var/lib/apt/lists/*

RUN sudo bash -c 'wget https://raw.githubusercontent.com/osrf/osrf-rosdep/master/gz/00-gazebo.list -O /etc/ros/rosdep/sources.list.d/00-gazebo.list' \
  && rosdep update

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME \
  && echo "\n# Added by blueboat_sitl Dockerfile:" >> /home/$USERNAME/.bashrc \
  && echo "source /usr/share/bash-completion/completions/git" >> /home/$USERNAME/.bashrc

USER $USERNAME
ENV USER=$USERNAME
ENV GZ_VERSION=garden

WORKDIR /home/$USERNAME/colcon_ws/src
# RUN vcs import < blueboat_sitl/blueboat_sitl.repos

RUN rosdep update

#RUN python3 -m pip install --upgrade pip setuptools==59.6.0

RUN rosdep install -y --from-paths . --ignore-src --skip-keys="gz-transport12 gz-sim7 gz-math7 gz-msgs9"

WORKDIR /home/$USERNAME/colcon_ws
RUN [ "/bin/bash" , "-c" , "\
  source /opt/ros/humble/setup.bash \
  && colcon build" ]

RUN rosdep update \
  && rosdep install -y --from-paths . --ignore-src --skip-keys="gz-transport12 gz-sim7 gz-math7 gz-msgs9"

USER root
RUN apt-get update && apt-get install -y nano
RUN apt-get -y --quiet --no-install-recommends install \
 libcgal-dev \
 libfftw3-dev

 RUN apt-get update && apt-get install -y \
 python3-pip \
 --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install opencv-python

RUN apt-get update && apt-get install -y \
    ros-humble-joy \
    && rm -rf /var/lib/apt/lists/*

ENV DIST=humble

RUN apt update \
 && apt install -y --no-install-recommends \
    ros-${DIST}-plotjuggler-ros \
 && apt clean

RUN apt-get update && apt-get install -y \
    qml-module-qtpositioning \
    qml-module-qtlocation

RUN apt-get install -y \
    python3-tk    

RUN python3 -m pip install gekko  

USER $USERNAME

USER root

RUN apt-get update && apt-get install -y ros-humble-joint-state-publisher

USER $USERNAME

