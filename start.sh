#Petit script pour lancer le binz
#ATTENTION: faire tourner dans le host du container docker-ressenti!
#ATTENTION: y'a encore des paramètre écrit en dur dans le code !

#zf181221.1537

while true ; do
    echo -e "
Et voilà, c'est parti pour un tour de carousel
"
    docker container rm -f -v docker-ressenti
    docker run -d -i -v `pwd`/:/root/work --name="docker-ressenti" docker-firefox-zf
    sleep 3
    docker exec -it docker-ressenti /bin/bash /root/work/ressenti-1.sh
#  sleep 10
done


