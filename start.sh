#Petit script pour lancer le binz
#ATTENTION: faire tourner dans le host du container docker-ressenti!
#ATTENTION: y'a encore des paramètre écrit en dur dans le code !

#zf190107.1521

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


docker container rm -f -v docker-ressenti
docker run -d -i -v `pwd`/:/root/work --name="docker-ressenti" docker-firefox-zf
sleep 3

while true ; do
    echo -e "
Et voilà, c'est parti pour un tour de carousel
"
    docker exec -it docker-ressenti /bin/bash /root/work/ressenti-1.sh
  sleep 10
done


