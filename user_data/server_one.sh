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

NAME=server-one

# Set hostname
sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4 $NAME/g" /etc/hosts
hostnamectl set-hostname  "$NAME"

#Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
sleep 20
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
DOCKER_OPTS="--log-driver json-file --log-opt max-size=10m --log-opt max-file=2"


echo "DONE!..."
date '+%Y-%m-%d %H:%M:%S'
