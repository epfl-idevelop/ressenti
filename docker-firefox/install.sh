#Petit script pour lancer le binz
#zf190206.1147

docker container rm -f -v docker-ressenti
docker container rm -f -v docker-firefox
docker image rm -f docker-firefox-zf

docker build -t "docker-ubuntu-zf" ~/docker-ubuntu/
docker build -t "docker-firefox-zf" .

echo -e "

Image docker-firefox-zf construite !

Après si on a besoin, il faut démarrer le container avec:
docker run -d -i -v `pwd`/../:/root/work -p 5959:5900 --name="docker-firefox" docker-firefox-zf

ensuite pour entrer dans le container il faut faire:
docker exec -it docker-firefox /bin/bash

ou pour entrer 'graphiquement' dans le container il faut faire (passwd=1234):
sudo apt install xvnc4viewer
xvncviewer localhost:5959

ou directement ceci:
docker exec -it docker-firefox /bin/bash commande_a_tourner

et pour enlever le container il faut faire:
docker container rm -f -v docker-firefox

et pour effacer l'image de firefox
docker container rm -f -v docker-firefox
docker image rm docker-firefox-zf


"

