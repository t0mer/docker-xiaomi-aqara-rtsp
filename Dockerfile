FROM python:3.9

# set workdir
WORKDIR /usr/src/app

# install dependencies
RUN apt update -yqq && \
	apt -y install liblivemedia-dev libjson-c-dev

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
