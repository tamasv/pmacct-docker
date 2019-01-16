FROM ubuntu:18.04  

MAINTAINER Tamas Varga <tamas@alapzaj.com>

RUN apt-get update && apt-get install -y git libpcap0.8-dev pkgconf build-essential librabbitmq-dev libmaxminddb-dev libjansson-dev libpq5 libpq-dev libtool autoconf automake && \
	cd /tmp && git clone https://github.com/pmacct/pmacct.git && cd /tmp/pmacct && git checkout 1.7.2 && \
	cd /tmp/pmacct && \
	./autogen.sh && \
	./configure --enable-plabel --enable-postgres --enable-rabbitmq --enable-jansson --enable-geoipv2 && \
	make && \
	make install && \
	rm -rf /root/.cache && rm -rf /tmp/*  && \
	apt-get remove --purge -y libtool autoconf automake build-essential pkgconf git libpcap0.8-dev librabbitmq-dev libmaxminddb-dev libjansson-dev && \
	apt-get install -y librabbitmq4 libmaxminddb0 libpcap0.8 libjansson4

WORKDIR /usr/local/sbin
CMD ["nfacctd","-f/config/nfacctd.conf"]
#ENTRYPOINT ["nfacctd","-f/config/nfacctd.conf"]
