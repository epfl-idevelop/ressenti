#Petit script pour installer K'ancienne version de Firefox 64
#zf190207.1141

firefox --version
apt -yq remove firefox
rm -rf /opt/firefox/ /etc/firefox/
# /root/.mozilla
#wget https://netix.dl.sourceforge.net/project/ubuntuzilla/mozilla/apt/pool/main/f/firefox-mozilla-build/firefox-mozilla-build_64.0.2-0ubuntu1_amd64.deb
dpkg -i /root/firefox-mozilla-build_64.0.2-0ubuntu1_amd64.deb
firefox --version

