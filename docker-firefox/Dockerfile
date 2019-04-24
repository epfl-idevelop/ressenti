#Dockerfile pour mettre un browser Firefox 64.x dans un container Docker
#zf190424.1358

#source: pour le download de la version 64.x: https://sourceforge.net/projects/ubuntuzilla/files/mozilla/apt/pool/main/f/firefox-mozilla-build/
#dépend de https://github.com/zuzu59/docker-ubuntu
#source: pour arrêter la telemetry: https://github.com/pyllyukko/user.js/
#source pour vnc: https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc
#use: sudo apt install xvnc4viewer
#use: docker run -d -i -v `pwd`/../:/root/work -p 5959:5900 --name="docker-firefox" docker-firefox-zf
#use: xvncviewer localhost:5959 (sans password)

#image de base
FROM docker-ubuntu-zf

MAINTAINER Christian Zufferey <christian@zufferey.com>

USER root

#partie Firefox version figée
RUN apt-get update && apt-get install -yq wget zip firefox
RUN apt -yq remove firefox
RUN wget https://netcologne.dl.sourceforge.net/project/ubuntuzilla/mozilla/apt/pool/main/f/firefox-mozilla-build/firefox-mozilla-build_64.0.2-0ubuntu1_amd64.deb
RUN apt install ./firefox-mozilla-build_64.0.2-0ubuntu1_amd64.deb
COPY test1.sh /root

#partie VNC
RUN apt-get install -yq x11vnc jwm xvfb feh
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd "" ~/.vnc/passwd
COPY alias /root
RUN echo "source /root/alias" >> /root/.bashrc

#partie utilitaires de debug
RUN apt-get install -yq net-tools

#partie entrypoint
COPY service_start.sh /root
RUN chmod 755 /root/service_start.sh
ENTRYPOINT /root/service_start.sh
WORKDIR /root

