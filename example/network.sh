#!/bin/bash

readonly hostname=seot-agent1
readonly ip=192.168.10.47/24
readonly router=192.168.10.1
readonly dns=192.168.10.1

# Change host name
sed -i -e "s/raspberrypi/${hostname}/" /etc/hosts
echo "${hostname}" > /etc/hostname

# Assign static ip
cat << EOS >> /etc/dhcpcd.conf
interface eth0
static ip_address=${ip}
static routers=${router}
static domain_name_servers=${dns}
EOS
