#!/bin/bash

sudo -H apt-get -y install python-software-properties debconf-utils apt-transport-https \
 ca-certificates curl software-properties-common

################################################################################
# Setup for latest Docker CE

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo -H apt-key add -

sudo -H apt-key fingerprint 0EBFCD88

sudo -H add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

################################################################################
# Setup for latest Mongo 4.0

# sudo -H apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
# --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

#echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/4.0 multiverse" \
# | sudo -H tee /etc/apt/sources.list.d/mongodb-org-4.0.list

################################################################################
# Setup for latest Mongo 3.6

sudo -H apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/3.6 multiverse" \
 | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

################################################################################
# Setup for Java and others

sudo -H add-apt-repository -y ppa:ricotz/experimental
sudo -H add-apt-repository -y ppa:webupd8team/java

sudo -H dpkg --add-architecture i386

sudo -H apt-get update

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" \
 | sudo -H debconf-set-selections

sudo -H apt-get -y install htop ncdu vim tmux zsh git gitk zip aspell aptitude \
 keychain gparted smartmontools build-essential nvme-cli oracle-java8-installer \
 oracle-java8-set-default python-pip exuberant-ctags cpulimit libgoo-canvas-perl \
 pcsc-tools pcscd opensc libnss3-tools sshpass nmap python-pyqtgraph socat \
 pyqt4-dev-tools pdftk lrzip p7zip p7zip-full libimage-exiftool-perl \
 ffmpeg postgresql-client python-dev fdupes fslint gthumb mc archivemount \
 openssh-server maven libcurl4-openssl-dev gcc g++ make pv

# Mongo shell and tools 3.6/4.0
sudo -H apt-get -y install mongodb-org-shell mongodb-org-tools

# ia32-libs is only available in mint - separate in new line to not fail above in Ubuntu
sudo -H apt-get -y install ia32-libs

sudo -H pip install -U pip 
sudo -H pip install setuptools
sudo -H pip install jump
sudo -H pip install docker-compose
sudo -H pip install pbkdf2
sudo -H pip install bcrypt
sudo -H pip install RBTools
sudo -H pip install natsort

################################################################################
# Setup for nodejs and angular/cli

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo -H apt-get -y install nodejs

sudo -H npm install -g @angular/cli

sudo -H apt-get -y install docker-ce

################################################################################
# Install docker
#
# To install specific version check
# sudo -H apt-cache madison docker-ce

sudo groupadd docker
sudo gpasswd -a $USER docker