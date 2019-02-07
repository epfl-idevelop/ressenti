#Petit script pour lancer une mesure de temps sur une liste de site
#ATTENTION: faire tourner ce script DANS le container docker-ressenti!

#zf190207.1626

time_page() {
    label=$1
    url=$2
    img=$3

    ztime=`date +%Y%m%d.%H%M%S`
    zduree=`/root/work/screenshot.sh $url $img`
    echo -e $ztime" "$zduree
    t=${zduree::-1}				                        #supprime le dernier car
    /root/work/send_prometheus.sh epfl $label $t 1
}




echo -e "triger 10"
/root/work/send_prometheus.sh epfl trig 10 1



echo -e "z.zufferey.com"
time_page "z.zufferey.com" "http://z.zufferey.com" "z.zufferey.com"

echo -e "www.epfl.ch"
time_page "www.epfl.ch" "https://www.epfl.ch" "www.epfl.ch"

echo -e "www.epfl.ch/wp-admin"
time_page "www.epfl.ch-wp-admin" "https://www.epfl.ch/wp-admin" "www.epfl.ch-wp-admin"

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
time_page "www.abcm.ch-wp" "http://www.abcm.ch/wp" "www.abcm.ch-wp"

#echo -e "www.makerspace-lausanne.ch"
time_page "www.makerspace-lausanne.ch" "http://www.makerspace-lausanne.ch" "www.makerspace-lausanne.ch"




echo -e "triger 1"
/root/work/send_prometheus.sh epfl trig 2 1

