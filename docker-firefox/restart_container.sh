#Petit script pour relancer le container firefox
#zf190207.1503

docker container rm -f -v docker-firefox
docker run -d -i -v `pwd`/../:/root/work -p 127.0.0.1:5960:5900 --name="docker-firefox" docker-firefox-zf
docker exec -it docker-firefox /bin/bash
