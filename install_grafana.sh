#!/bin/bash

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

#Telecharge le fichier d'installation
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_4.5.2_amd64.deb
sudo apt-get install -y -qq adduser libfontconfig
sudo dpkg -i grafana_4.5.2_amd64.deb

echo "**Ajouter le repo**"
#Ajouter repository
echo "deb https://packagecloud.io/grafana/stable/debian/jessie main" | sudo tee -a /etc/apt/sources.list

echo "**Installer grafana**"
#Installer Grafana
sudo apt-get -y -qq update
sudo apt-get install -y -qq grafana

echo "**Remove le repo**"
rm grafana_4.5.2_amd64.deb
