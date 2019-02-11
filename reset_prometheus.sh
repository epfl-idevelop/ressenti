#Petit script pour mettre à zéro toutes les valeurs du graphe Prometheus

#zf190207.1813


echo -e "overlay"
./send_prometheus.sh epfl overlay 0 0.85

echo -e "z.zufferey.com"
./send_prometheus.sh epfl z.zufferey.com 0 0.85

echo -e "www.epfl.ch"
./send_prometheus.sh epfl www.epfl.ch 0 0.85

echo -e "www.epfl.ch-wp-admin"
./send_prometheus.sh epfl www.epfl.ch-wp-admin 0 0.85

echo -e "actu.epfl.ch"
./send_prometheus.sh epfl actu.epfl.ch 0 0.85

echo -e "memento.epfl.ch"
./send_prometheus.sh epfl memento.epfl.ch 0 0.85

echo -e "people.epfl.ch"
./send_prometheus.sh epfl people.epfl.ch 0 0.85

echo -e "gel.epfl.ch"
./send_prometheus.sh epfl gel.epfl.ch 0 0.85

echo -e "jahia.epfl.ch"
./send_prometheus.sh epfl jahia.epfl.ch 0 0.85

echo -e "www.abcm.ch"
./send_prometheus.sh epfl www.abcm.ch 0 0.85

echo -e "www.abcm.ch-wp"
./send_prometheus.sh epfl www.abcm.ch-wp 0 0.85

echo -e "www.makerspace-lausanne.ch"
./send_prometheus.sh epfl www.makerspace-lausanne.ch 0 0.85

