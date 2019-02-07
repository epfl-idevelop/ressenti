#Petit script pour tester la vitesse de lecture de Prometheus
#zf190207.1545

./send_prometheus.sh 25
sleep 15
./send_prometheus.sh 15

sleep 15

./send_prometheus.sh 25
sleep 15
./send_prometheus.sh 15


