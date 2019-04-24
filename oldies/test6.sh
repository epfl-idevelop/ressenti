#Petit script pour tester la vitesse de lecture de Prometheus
#zf190207.1622

./send_prometheus.sh epfl toto 25 1
sleep 15
./send_prometheus.sh epfl toto 15 1

sleep 15

./send_prometheus.sh epfl toto 25 1
sleep 15
./send_prometheus.sh epfl toto 15 1


