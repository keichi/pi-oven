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
PATH=$PATH:/usr/local/bin

# Install RTMIULib
git clone --depth 1 https://github.com/RPi-Distro/RTIMULib.git
pushd RTIMULib/Linux/python || exit 1
python3 setup.py build
python3 setup.py install
popd
rm -rf RTIMULib

# Install SenseHat
apt-get -y install libjpeg-dev i2c-tools
pip3 install --upgrade pip
pip3 install sense-hat

# Enable SenseHat Device Tree Overlay
echo 'dtoverlay=rpi-sense' >> /boot/config.txt

# Enable I2C
echo 'i2c-dev' >> /etc/modules
echo 'dtparam=i2c_arm=on' >> /boot/config.txt

# Clean apt cache
apt-get clean
