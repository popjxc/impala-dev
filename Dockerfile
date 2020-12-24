FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install sudo
RUN adduser --disabled-password --gecos '' impdev
RUN echo 'impdev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER impdev

RUN sudo apt-get --yes install git
RUN git clone https://git-wip-us.apache.org/repos/asf/impala.git ~/Impala
WORKDIR ~/Impala
ENV IMPALA_HOME=/home/impdev/Impala
RUN sed -i 's/time/# time/g' ${IMPALA_HOME}/bin/bootstrap_development.sh
RUN echo "time -p ./buildall.sh -format -notests" >> ${IMPALA_HOME}/bin/bootstrap_development.sh
RUN ${IMPALA_HOME}/bin/bootstrap_development.sh
