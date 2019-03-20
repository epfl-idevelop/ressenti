#Petit script pour lancer une mesure de temps sur une liste de site
#ATTENTION: faire tourner ce script DANS le container docker-ressenti!

#zf190320.1134

time_page() {
    label=$1
    url=$2
    img=$3

    ztime=`date +%Y%m%d.%H%M%S`
    zduree=`/root/work/screenshot.sh $url $img`
    echo -e $ztime" "$zduree
    t=${zduree::-1}				                        #supprime le dernier car
    /root/work/send_prometheus.sh ressenti_epfl_firefox_siipc6 $label $t 1
}


echo -e "z.zufferey.com"
time_page "z.zufferey.com" "http://z.zufferey.com" "z.zufferey.com"

echo -e "www.epfl.ch"
time_page "www.epfl.ch" "https://www.epfl.ch" "www.epfl.ch"

echo -e "www.epfl.ch/wp-admin"
time_page "www.epfl.ch-wp-admin" "https://www.epfl.ch/wp-admin" "www.epfl.ch-wp-admin"

echo -e "dcsl.epfl.ch"
time_page "dcsl.epfl.ch" "https://dcsl.epfl.ch" "dcsl.epfl.ch"

echo -e "actu.epfl.ch"
time_page "actu.epfl.ch" "https://actu.epfl.ch" "actu.epfl.ch"

echo -e "memento.epfl.ch"
time_page "memento.epfl.ch" "https://memento.epfl.ch" "memento.epfl.ch"

echo -e "people.epfl.ch"
time_page "people.epfl.ch" "https://people.epfl.ch/christian.zufferey" "people.epfl.ch"

echo -e "gel.epfl.ch"
time_page "gel.epfl.ch" "https://gel.epfl.ch" "gel.epfl.ch"

echo -e "jahia.epfl.ch"
time_page "jahia.epfl.ch" "https://jahia.epfl.ch" "jahia.epfl.ch"

#echo -e "www.abcm.ch"
#time_page "www.abcm.ch" "https://www.abcm.ch" "www.abcm.ch"

#echo -e "www.abcm.ch_wp"
#time_page "www.abcm.ch-wp" "http://www.abcm.ch/wp" "www.abcm.ch-wp"

echo -e "www.makerspace-lausanne.ch"
time_page "www.makerspace-lausanne.ch" "http://www.makerspace-lausanne.ch" "www.makerspace-lausanne.ch"

echo -e "hivebrite.com"
time_page "hivebrite.com" "https://hivebrite.com" "hivebrite.com"

echo -e "epfl-test.hivebrite.com"
time_page "epfl-test.hivebrite.com" "https://epfl-test.hivebrite.com" "epfl-test.hivebrite.com"

echo -e "epfl.hivebrite.ch"
time_page "epfl.hivebrite.ch" "https://epfl.hivebrite.ch" "epfl.hivebrite.ch"

