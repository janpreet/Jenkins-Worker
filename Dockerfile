FROM ubuntu
LABEL Maintainer="Janpreet Singh"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
         apt-get full-upgrade

RUN apt-get install -y \
    git \
    wget \
    openssh-server \
    openjdk-8-jdk

RUN /usr/bin/ssh-keygen -A

ADD ./sshd_config /etc/ssh/sshd_config

RUN useradd jenkins -m -s /bin/bash

RUN echo root:jenkins | chpasswd

RUN echo "jenkins  ALL=(ALL)  ALL" >> etc/sudoers

RUN mkdir -p /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]