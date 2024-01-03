FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION 0.10.0

RUN apt-get update && \
    apt-get install -y build-essential flex bison nfs-client curl pkg-config

RUN apt-get clean all

ADD https://github.com/unfs3/unfs3/releases/download/unfs3-${VERSION}/unfs3-${VERSION}.tar.gz /

RUN tar zxf /unfs3-${VERSION}.tar.gz && \
    ls -la && \
    cd /unfs3-${VERSION} && \
    ./configure && make && make install

ADD exports.dist /etc/exports
ADD start.sh /start.sh

RUN mkdir -p /run/sendsigs.omit.d

RUN chmod +x /start.sh

EXPOSE 111/udp 111/tcp 2049/tcp 2049/udp

CMD /start.sh
