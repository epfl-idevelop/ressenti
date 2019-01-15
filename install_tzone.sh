#!/bin/bash
# Petit script pour configurer la bonne timezone
# zf19015.1539
# source: https://serverfault.com/questions/84521/automate-dpkg-reconfigure-tzdata

apt update
apt install tzdata
ln -fs /usr/share/zoneinfo/Europe/Zurich /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
