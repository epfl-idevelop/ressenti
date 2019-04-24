#Petit script pour lancer le binz
#zf181221.1358

docker build -t "docker-firefox-zf" .
docker run -d -i -v `pwd`/../:/root/work --name="docker-ressenti" docker-firefox-zf


echo -e "


Après il faut faire:

docker exec -it docker-ressenti /bin/bash

puis à l'intérieur du container:

./test1.sh

ou directement ceci:

docker exec -it docker-ressenti /bin/bash /root/work/the_script


"

