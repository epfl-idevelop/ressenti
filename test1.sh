#Petit script pour tester juste la durée d'une page 
#zf181220.1410

echo -e "z.zufferey.com"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh http://z.zufferey.com z.zufferey.com

echo -e "www.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://www.epfl.ch www.epfl.ch

echo -e "www.epfl.ch/wp-admin"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://www.epfl.ch/wp-admin www.epfl.ch-wp-admin

echo -e "actu.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://actu.epfl.ch actu.epfl.ch

echo -e "memento.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://memento.epfl.ch memento.epfl.ch

echo -e "people.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://people.epfl.ch/christian.zufferey people.epfl.ch

echo -e "gel.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://gel.epfl.ch gel.epfl.ch

echo -e "jahia.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://jahia.epfl.ch jahia.epfl.ch

