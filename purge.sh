#!/bin/bash
#Petit script pour nettoyer tout le binz
#zf190115.1601

docker container ls -a
docker container rm -f -v docker-ressenti
#docker image rm -f docker-firefox-zf

docker container ls -a

