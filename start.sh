
#Petit script pour lancer le binz
#ATTENTION: faire tourner dans le host du container docker-ressenti!
#ATTENTION: y'a encore des paramètre écrit en dur dans le code !

#zf190424.1029

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
docker container rm -f -v docker-firefox
docker run -d -i -v `pwd`/:/root/work -p 127.0.0.1:5959:5900 --name="docker-ressenti" docker-firefox-zf
sleep 3



exit






instance="ressenti_epfl_firefox_siipc6"
echo -e "On démarre la boucle des shots dans 15 secondes..."
./reset_prometheus.sh
./send_prometheus.sh $instance shot 0 1
./send_prometheus.sh $instance trig 10 1
sleep 15
./send_prometheus.sh $instance trig 0 1

while true ; do
    echo -e "Et voilà, c'est parti pour un tour de carousel"
    date
    ./send_prometheus.sh $instance shot 0 1
    zt1=`date +%s.%N`
    docker exec -it docker-ressenti /bin/bash /root/work/ressenti-1.sh
    zt2=`date +%s.%N`
    zduree=`echo "scale=4;($zt2-$zt1)/10" |bc`
    echo -e "Et voilà, c'est terminé"
    ./send_prometheus.sh $instance shot $zduree 1
    sleep 60
done


