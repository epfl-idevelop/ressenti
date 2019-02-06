#Dockerfile pour mettre un browser Firefox 64.x dans un container Docker
#zf190206.1033
#dépend de https://github.com/zuzu59/docker-ubuntu
#source pour vnc: https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc
#use: sudo apt install xvnc4viewer
#use: docker run -d -i -v `pwd`/../:/root/work -p 5959:5900 --name="docker-firefox" docker-firefox-zf
#use: xvncviewer localhost:5959

#image de base
FROM docker-ubuntu-zf

MAINTAINER Christian Zufferey <christian@zufferey.com>

USER root

#partie Firefox version figée
RUN apt-get update && apt-get install -yq wget

RUN wget https://netix.dl.sourceforge.net/project/ubuntuzilla/mozilla/apt/pool/main/f/firefox-mozilla-build/firefox-mozilla-build_64.0.2-0ubuntu1_amd64.deb
#RUN dpkg -i firefox-mozilla-build_64.0.2-0ubuntu1_amd64.deb

#partie VNC
#RUN apt-get install -yq x11vnc xvfb feh
#RUN mkdir ~/.vnc
#RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

#partie utilitaires de debug
#RUN apt-get install -yq net-tools

#partie entrypoint
COPY service_start.sh /root
RUN chmod 755 /root/service_start.sh
ENTRYPOINT /root/service_start.sh
WORKDIR /root

