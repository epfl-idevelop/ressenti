#!/bin/bash
#Permet de lancer le serveur VNC dans le container
#zf190206.1029
#source: https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc

alias zview='feh -.'

x11vnc -forever -usepw -create &
/bin/bash


