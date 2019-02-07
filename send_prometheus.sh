#Petit script pour envoyer à Prometheus les datas
#zf190207.1617

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax: ./send_prometheus.sh location_test site_label load_time page_similar"
    echo -e "\nSyntax: ./send_prometheus.sh epfl toto 12 0.85\n\n"
    exit
fi

prometheus_ip1="172.22.0.1:9091"
prometheus_ip2="10.0.2.15:9991"

zsend() {
    cat <<__EOF | curl --data-binary @- http://$1/metrics/job/resenti/instance/$3
        # TYPE resenti_load_time gauge
        resenti_load_time {location="$2"} $4
        # TYPE resenti_page_changed gauge
        resenti_page_similar $5
__EOF
}

zsend $prometheus_ip1 $1 $2 $3 $4
#zsend $prometheus_ip2 $1 $2 $3 $4
