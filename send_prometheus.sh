#Petit script pour envoyer à Prometheus les datas
#zf190214.1556

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax: ./send_prometheus.sh location_test site_label load_time page_similar\n"
    echo -e "./send_prometheus.sh ressenti_epfl_firefox_siipc6 toto 10 0.85\n\n"
    echo -e "./send_prometheus.sh ressenti_epfl_firefox_siipc6 toto 0 0.85\n\n"
    exit
fi

zsend() {
    cat <<__EOF | curl -s --data-binary @- http://$1/metrics/job/resenti/instance/$3
        # TYPE resenti_load_time gauge
        $2_load_time $4
        # TYPE resenti_page_changed gauge
        $2_page_similar $5
__EOF
}

prometheus_ip1="172.22.0.1:9091"
prometheus_ip2="172.22.0.1:9991"

zsend $prometheus_ip1 $1 $2 $3 $4 
zsend $prometheus_ip2 $1 $2 $3 $4


