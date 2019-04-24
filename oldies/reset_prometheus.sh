#Petit script pour mettre à zéro toutes les valeurs du graphe Prometheus

#zf190214.1610

site="ressenti_epfl_firefox_siipc6"

echo -e "overlay"
./send_prometheus.sh $site overlay 0 0.85

echo -e "z.zufferey.com"
./send_prometheus.sh $site z.zufferey.com 0 0.85

echo -e "www.epfl.ch"
./send_prometheus.sh $site www.epfl.ch 0 0.85

echo -e "www.epfl.ch-wp-admin"
./send_prometheus.sh $site www.epfl.ch-wp-admin 0 0.85

echo -e "dcsl.epfl.ch"
./send_prometheus.sh $site dcsl.epfl.ch 0 0.85

echo -e "actu.epfl.ch"
./send_prometheus.sh $site actu.epfl.ch 0 0.85

echo -e "memento.epfl.ch"
./send_prometheus.sh $site memento.epfl.ch 0 0.85

echo -e "people.epfl.ch"
./send_prometheus.sh $site people.epfl.ch 0 0.85

echo -e "gel.epfl.ch"
./send_prometheus.sh $site gel.epfl.ch 0 0.85

echo -e "jahia.epfl.ch"
./send_prometheus.sh $site jahia.epfl.ch 0 0.85

#echo -e "www.abcm.ch"
#./send_prometheus.sh $site www.abcm.ch 0 0.85

#echo -e "www.abcm.ch-wp"
#./send_prometheus.sh $site www.abcm.ch-wp 0 0.85

echo -e "www.makerspace-lausanne.ch"
./send_prometheus.sh $site www.makerspace-lausanne.ch 0 0.85

