#!/bin/bash
#Permet de lancer le serveur VNC dans le container
#zf190207.1411
#source: https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc

alias zview='feh -.'

/root/work/docker-firefox/restore_firefox_config.sh

x11vnc -forever -usepw -create &

/bin/bash


