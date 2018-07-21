#!/bin/bash
#petit script a lancer pour installer selenium
#zf041117.1310

virtFold="venv"

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

echo "**Getting last updates**"
sudo apt-get  -qq update
sudo apt-get -y -qq upgrade

echo "**Installing python, firefox and xvfb**"
## installing different program
sudo apt-get install -y -qq python3
sudo apt-get install -y -qq python3-dev python3-pip
sudo apt-get install -y -qq xvfb
sudo apt-get install -y -qq firefox

pip install setuptools

echo "**Getting drivers for firefox and chrome**"
## Installing Geckodriver for firefox
wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz
	sudo sh -c 'tar -x geckodriver -zf geckodriver-v0.18.0-linux64.tar.gz -O > /usr/bin/geckodriver'
	sudo chmod +x /usr/bin/geckodriver
	rm geckodriver-v0.18.0-linux64.tar.gz

## Installing Chromedriver for chrome
wget https://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip
	unzip chromedriver_linux64.zip
	sudo chmod +x chromedriver
	sudo mv chromedriver /usr/bin/
	rm chromedriver_linux64.zip

sudo chown -R "$USER:$USER" "$HOME"

echo "**Setting up virtual environment**"
## Installing virtualenv and activate a new environment
sudo apt-get install -y -qq virtualenv

if [ -d $virtFold ];
then
    rm -rf $virtFold
fi

virtualenv -p /usr/bin/python3 $virtFold
source $virtFold/bin/activate

echo "**Installing selenium and virtual displays**"
## Installing selenium and pyvirtualdisplay to emulate a screen
pip install selenium
pip install pyvirtualdisplay

## Desactivate virtual environment
deactivate
