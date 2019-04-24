
#Petit script pour lancer le binz
#ATTENTION: faire tourner dans le host du container docker-ressenti!
#ATTENTION: il faut installer en premier le container zubuntu: https://github.com/zuzu59/docker-ubuntu
#ATTENTION: puis il faut builder le container firefox: ~/ressenti/docker-firefox/install.sh

#zf190424.1411

zNAME="ressenti"
echo -e "

Afin de pouvoir garder $zNAME en marche tout en pouvant quitter la console, il serait bien de le faire tourner dans un 'screen' avec:

screen -S $zNAME    pour entrer dans screen
./start.sh             pour lancer le serveur WEB dans screen
CTRL+a,d               pour sortir de screen en laissant tourner le serveur
screen -r $zNAME    pour revenir dans screen
screen -x $zNAME    pour revenir à plusieurs dans screen
CTRL+d                 pour terminer screen
screen -list           pour lister tous les screens en fonctionement

"
read -p "Appuyer une touche pour démarrer $zNAME"

echo ---------- start
mkdir images
docker container rm -f -v docker-ressenti
#docker container rm -f -v docker-firefox
docker run -d -i -v `pwd`/:/root/work -p 127.0.0.1:5959:5900 --name="docker-ressenti" docker-firefox-zf
sleep 3

echo -e "

Pour entrer dans le container:
docker exec -it docker-ressenti /bin/bash

Pour effacer complètement le container:
docker container rm -f -v docker-ressenti

"

./tst_flask/async_ressenti.py


