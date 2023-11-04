FROM ubuntu:latest

# set workdir
WORKDIR /usr/src/app

# install dependencies
RUN apt update -yqq
RUN apt install -yqq wget

RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/libl/liblivemedia/liblivemedia-dev_2020.01.19-1build1_amd64.deb
RUN dpkg -i liblivemedia-dev_2020.01.19-1build1_amd64.deb

RUN apt -y install  libjson-c-dev python3-pip

# cleanup
RUN apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# install python dependencies
RUN pip3 install python-miio

# clone code
RUN git clone https://github.com/pccr10001/videoP2Proxy.git .

# build code
RUN ./autogen.sh
RUN make
RUN make install

# run code
CMD videop2proxy --ip $IP --token $TOKEN --rtsp 8554

# expose port
EXPOSE 8554
