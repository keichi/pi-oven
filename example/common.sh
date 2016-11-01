#!/bin/bash

# Install packages
apt-get -y update
apt-get -y upgrade
apt-get -y install git tmux vim

# Change locale to ja_JP and timezone to Asia/Tokyo
sed -i -e '/en_GB.UTF-8/d' /etc/locale.gen
echo 'ja_JP.UTF8 UTF-8' >> /etc/locale.gen
locale-gen
update-locale LANG=ja_JP.UTF-8
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Install dependencies for building python
apt-get -y install build-essential zlib1g-dev libbz2-dev libssl-dev \
libreadline-dev libncurses5-dev libsqlite3-dev libgdbm-dev libdb-dev \
libexpat-dev libpcap-dev liblzma-dev libpcre3-dev

# Build and install python 3.5 from source
curl https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz | tar xzvf -
pushd Python-3.5.2 || exit 1
./configure
make -j 4
make install
popd
rm -rf Python-3.5.2

# Clean apt cache
apt-get clean
