#Petit script pour tester le curl pour pusher sur Prometheus

#zf190129.1642

#prometheus_ip="172.22.0.1"
prometheus_ip="127.0.0.1"

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax: ./test_curl1.sh time\n\n"
    exit
fi

label=toto
t=$1
c=2

    cat <<__EOF | curl --data-binary @- http://$prometheus_ip:9991/metrics/job/zuzuresenti/instance/$label
        # TYPE zuzu_resenti_load_time gauge
        zuzu_resenti_load_time {location="berlin"} $t
        # TYPE zuzu_resenti_page_changed gauge
        zuzu_resenti_page_changed $c
__EOF
