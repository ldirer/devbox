FROM ubuntu:14.04
# http://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh


# Inspiration:
# https://github.com/shykes/devbox/blob/master/Dockerfile

RUN apt-get update -y && apt-get install -y git \
                curl \
                vim \
                strace \
                diffstat \
                pkg-config \
                cmake \
                build-essential \
                tmux \
                gcc \
                g++ \
                software-properties-common

# Setup home environment
RUN useradd dev -G sudo
RUN echo "dev:dev" | chpasswd
RUN mkdir /home/dev && chown -R dev: /home/dev
RUN mkdir -p /home/dev/bin /home/dev/lib /home/dev/include
ENV PATH /home/dev/bin:$PATH
ENV PKG_CONFIG_PATH /home/dev/lib/pkgconfig
ENV LD_LIBRARY_PATH /home/dev/lib


RUN sudo apt-add-repository ppa:fish-shell/release-2
RUN apt-get update -y && apt-get install -y fish

## My dotfiles 
RUN git clone --recursive https://github.com/ldirer/dotfiles.git /home/dev/.dotfiles
RUN /bin/bash /home/dev/.dotfiles/install.sh

WORKDIR /home/dev
USER dev
