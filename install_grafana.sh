#!/bin/bash

#Télécharge le fichier d'installation
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_4.5.2_amd64.deb
sudo apt-get install -y -qq adduser libfontconfig
sudo dpkg -i grafana_4.5.2_amd64.deb


echo "**Ajouter le repo**"
#Ajouter repository
sudo echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" >> /etc/apt/sources.list

echo "**Installer grafana**"
#Installer Grafana
sudo apt-get -y -qq update
sudo apt-get install -y -qq grafana

echo "**Remove le repo**"
rm grafana_4.5.2_amd64.deb
