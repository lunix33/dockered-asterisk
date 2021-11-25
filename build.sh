#!/bin/bash

##
# Build and install script for Asterisk.
#
# This script is meant to be executed inside a Docker container.
##

set -euo pipefail

deps=(
  libc6 libncurses6 libedit2 \
  libssl1.1 libuuid1 libxml2 \
  libsqlite3-0 libmysqlclient21 unixodbc libpq5 libct4 libsybdb5 \
  liblua5.3-0 libspeex1 libspeexdsp1 \
  libogg0 libcodec2-0.9 libvorbis0a \
  libvorbisenc2 libvorbisfile3 libcurl4 \
  libsrtp2-1 zlib1g libc-client2007e \
  libjack0 libresample1 libiksemel3 \
  libqxmpp1 libportaudio2 libportaudiocpp0 \
  libgmime-3.0-0 libunbound8 libneon27 \
  libical3 libldap-2.4-2 libspandsp2
)
build_deps=(
  build-essential curl git xmlstarlet \
  libc6-dev libncurses-dev libedit-dev \
  libssl-dev uuid-dev libxml2-dev \
  libsqlite3-dev libmysqlclient-dev unixodbc-dev libpq-dev freetds-dev \
  liblua5.3-dev libspeex-dev libspeexdsp-dev \
  libogg-dev libcodec2-dev  libvorbis-dev \
  libcurl4-openssl-dev libsrtp2-dev zlib1g-dev \
  libc-client2007e-dev libjack-dev libresample1-dev \
  libiksemel-dev libqxmpp-dev portaudio19-dev \
  libgmime-3.0-dev libunbound-dev libneon27-dev \
  libical-dev libldap2-dev libspandsp-dev
)

## Build package and install
echo "==== Installing dependancies and build tools ===="
export DEBIAN_FRONTEND="noninteractive"
apt-get update
apt-get install -y \
  ${deps[@]} \
  ${build_deps[@]}

echo "==== Getting Asterisk source code ===="
git clone --depth 1 --branch 19.0.0 https://github.com/asterisk/asterisk.git
cd ./asterisk

echo "==== Building and installing Asterisk ===="
./configure --with-jansson-bundled
make menuselect.makeopts
menuselect/menuselect \
  --enable app_voicemail_imap \
  --enable app_voicemail_odbc \
  --enable res_config_mysql
make
make install
make samples

# Cleanup
echo "==== Remove source ===="
cd ..
rm -fr asterisk
rm build.sh

echo "==== Cleanup ===="
apt-get purge -y ${build_deps[@]}
apt-get autoremove -y
apt-get clean
