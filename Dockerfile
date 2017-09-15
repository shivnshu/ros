FROM ros:indigo-robot

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    build-essential \
    qtbase5-dev

