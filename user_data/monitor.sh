#!/bin/bash -ex
#sleep 15
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo BEGIN

echo "Version 1"

date '+%Y-%m-%d %H:%M:%S'

echo "vm.max_map_count=262144" | tee -a /etc/sysctl.conf
sysctl -w vm.max_map_count=262144

apt-get update
sleep 20
apt-get -y install awscli net-tools mc software-properties-common ca-certificates curl gnupg
sleep 15
install -m 0755 -d /etc/apt/keyrings

NAME=monitor

# Set hostname
sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4 $NAME/g" /etc/hosts
hostnamectl set-hostname  "$NAME"


echo "DONE!..."
date '+%Y-%m-%d %H:%M:%S'
