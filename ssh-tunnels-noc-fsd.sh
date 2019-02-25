#!/bin/bash
#Petit script pour creuser rapidement les tunnels ssh pour pouvoir utiliser le serveur prometheus de notre infra NOC de idev-fsd
#ATTENTION: à faire tourner sur le MAC, machine host de la VM Ubuntu !
#zf190225.1620

#pour la gateway de Prometheus de NOC à ma machine siipc6
ssh -f -N -L 9991:localhost:9091 czufferey@fl-8-21.zhdk.cloud.switch.ch

#pour la gateway de Prometheus de ma machine ssipc6 à ma VM ubuntu (virtualbox) sur siipc6
ssh -f -N -R 9891:localhost:9991 zuzu@localhost -p 2222

#pour Grafana de NOC sur siipc6
ssh -f -N -L 9992:localhost:9092 czufferey@fl-8-21.zhdk.cloud.switch.ch

