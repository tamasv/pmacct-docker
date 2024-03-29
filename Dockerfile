FROM ubuntu:focal 

ENV pmacct_version 1.7.7

MAINTAINER Tamas Varga <tamas@alapzaj.com>
LABEL maintainer="tamas@alapzaj.com"
LABEL version="${pmacct_version}"
LABEL description="PMACCT netflow collector in a container"
LABEL features.label1="--enable-pgsql" 
LABEL features.label2="--enable-rabbitmq" 
LABEL features.label3="--enable-jansson" 
LABEL features.label4="--enable-geoipv2"

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y git libpcap0.8-dev pkgconf build-essential librabbitmq-dev libmaxminddb-dev libjansson-dev libpq5 libpq-dev libtool autoconf automake zlib1g-dev && \
	cd /tmp && git clone https://github.com/pmacct/pmacct.git && cd /tmp/pmacct && git checkout ${pmacct_version} && \
	cd /tmp/pmacct && \
	./autogen.sh && \
	./configure --enable-pgsql --enable-rabbitmq --enable-jansson --enable-geoipv2 && \
	make && \
	make install && \
	rm -rf /root/.cache && rm -rf /tmp/*  && \
	apt-get remove --purge -y libtool autoconf automake build-essential pkgconf git libpcap0.8-dev librabbitmq-dev libmaxminddb-dev libjansson-dev libpq-dev && \ 
	apt-get install -y librabbitmq4 libmaxminddb0 libpcap0.8 libjansson4

RUN mkdir /config
VOLUME /config

WORKDIR /usr/local/sbin
CMD ["nfacctd","-f/config/nfacctd.conf"]
