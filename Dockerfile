FROM ubuntu:20.04 as build

WORKDIR /usr/src/
COPY build.sh ./build.sh
RUN /bin/bash ./build.sh

VOLUME [ "/etc/asterisk", "/var/spool/asterisk", "/var/lib/asterisk" ]
WORKDIR /var/spool/asterisk
CMD asterisk -fvvv
