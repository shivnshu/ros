FROM ros:indigo-robot

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    build-essential \
    qtbase5-dev \
    ros-indigo-ros-tutorials \
    python-catkin-tools

RUN echo "source /opt/ros/indigo/setup.bash" >> /root/.bashrc

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

WORKDIR /home/developer

# Additional pkgs as required
RUN apt-get update && apt-get install -y ros-indigo-gazebo-ros-pkgs ros-indigo-gazebo-ros-control firefox

# Put them at last
USER developer
ENV HOME /home/developer
ENV QT_X11_NO_MITSHM 1

SHELL ["bash"]
