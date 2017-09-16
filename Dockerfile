FROM ros:indigo-robot

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    wget \
    build-essential \
    qtbase5-dev \
    ros-indigo-ros-tutorials \
    python-catkin-tools

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN echo "source /opt/ros/indigo/setup.bash" >> /home/developer/.bashrc
WORKDIR /home/developer

# Additional pkgs as required
RUN apt-get update && apt-get install -y \
  ros-indigo-gazebo-ros-pkgs \
  ros-indigo-gazebo-ros-control \
  ros-indigo-husky-simulator \
  ros-indigo-rqt-graph

RUN echo "export HUSKY_GAZEBO_DESCRIPTION=\$(rospack find husky_gazebo)/urdf/description.gazebo.xacro" >> /home/developer/.bashrc

# Put them at last
USER developer
ENV HOME /home/developer
ENV QT_X11_NO_MITSHM 1

# Find another way
# Download models from https://bitbucket.org/osrf/gazebo_models/downloads/?tab=downloads
RUN mkdir -p /home/developer/.gazebo/models
ADD models /home/developer/.gazebo/models

SHELL ["bash"]
