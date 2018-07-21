#!/bin/bash
#petit script a lancer pour installer influxDB ainsi que le module pour python
#lm021217.2041

virtFold="venv"

echo "**Ajouter le repo**"
#Ajouter le repo
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

echo "**Installer influxDB**"
#installer influxdb
sudo apt-get -y -qq update && sudo apt-get install -y -qq influxdb

echo "**Installer le module pour python**"
# Installer module pour python
virtualenv -p /usr/bin/python3 $virtFold
source $virtFold/bin/activate

pip install influxDB

echo "**Desactiver l'environnement virtuel**"
deactivate
