#!/bin/bash

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"


echo "**Update apt to include grafana**"
#Update apt to include grafana
echo "deb https://packagecloud.io/grafana/stable/debian/ stretch main" | sudo tee -a /etc/apt/sources.list
curl https://packagecloud.io/gpg.key | sudo apt-key add -

echo "**Installer grafana**"
#Installer Grafana
sudo apt-get -y -qq update
sudo apt-get install -y -qq grafana
