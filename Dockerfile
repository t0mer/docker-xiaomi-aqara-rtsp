FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive
# set workdir
WORKDIR /usr/src/app

# install dependencies
RUN apt update -yqq

RUN apt -y install libjson-c-dev python3-pip liblivemedia-dev git build-essential python3-dev autoconf automake libtool pkg-config libssl-dev

# cleanup
RUN apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# install python dependencies
RUN pip3 install python-miio

# clone code
#RUN git clone https://github.com/pccr10001/videoP2Proxy.git
RUN git clone https://github.com/miguelangel-nubla/videoP2Proxy.git
WORKDIR videoP2Proxy

# build code
RUN ./autogen.sh
RUN make
RUN make install

# run code
CMD videop2proxy --ip $IP --token $TOKEN --rtsp 8554

# expose port
EXPOSE 8554
