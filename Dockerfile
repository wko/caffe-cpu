FROM ubuntu:14.04
MAINTAINER Walter Forkel <walter@forkel.eu>

LABEL Description="Provides the environment and all dependencies for the caffe deep learning framework" Version="0.1"

RUN apt-get -y update
RUN apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler python-dev
RUN apt-get install -y --no-install-recommends libboost-all-dev
RUN apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev liblapack3 liblapack-dev libopenblas-base libopenblas-dev
RUN apt-get install -y git vim python-pip
RUN apt-get install -y gfortran build-essential

RUN useradd -m caffe
USER caffe
WORKDIR /home/caffe
RUN git clone https://github.com/BVLC/caffe.git ~/caffe
USER root
RUN for req in $(cat caffe/python/requirements.txt); do pip install $req; done
USER caffe
VOLUME /home/caffe
