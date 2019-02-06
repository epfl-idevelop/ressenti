#Petit script pour relancer le container firefox
#zf190206.1128

docker container rm -f -v docker-firefox
docker run -d -i -v `pwd`/../:/root/work -p 5959:5900 --name="docker-firefox" docker-firefox-zf
docker exec -it docker-firefox /bin/bash
