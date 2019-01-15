#!/bin/bash
#Petit script pour nettoyer tout le binz
#zf190115.1603

docker container ls -a
docker image ls
docker container rm -f -v docker-firefox
docker image rm -f docker-firefox-zf
docker container ls -a
docker image ls

k#./list.sh
