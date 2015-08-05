#!/bin/bash

# Install or update
install_or_update () {
  if ! apt-show-versions $1 | grep uptodate; then
    echo "Installing package $1..."
    sudo apt-get install -y $1
  fi
}

program_installed () {
  hash $1 >/dev/null 2>&1
}

# Update apt-get index
sudo apt-get update
sudo apt-get -y install apt-show-versions

# Essentials
install_or_update git-core
install_or_update git
install_or_update curl
install_or_update build-essential

install_or_update openjdk-7-jre

if [ ! -f /usr/share/elasticsearch/bin/elasticsearch ]; then
  if [ -f elasticsearch-1.7.1.deb ]; then
    rm elasticsearch-1.7.1.deb
  fi
  wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.deb
  sudo dpkg -i elasticsearch-1.7.1.deb
fi

sudo cp /vagrant/files/elasticsearch.yml /etc/elasticsearch/

sudo service networking restart
sudo service elasticsearch restart
