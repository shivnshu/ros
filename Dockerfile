FROM ros:indigo-robot

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    build-essential \
    qtbase5-dev \
    ros-indigo-ros-tutorials \
    python-catkin-tools

WORKDIR /root/

RUN echo "source /opt/ros/indigo/setup.bash" >> /root/.bashrc

# Additional pkgs as required
RUN apt-get update && apt-get install -y ros-indigo-gazebo-ros-pkgs ros-indigo-gazebo-ros-control

SHELL ["bash"]
