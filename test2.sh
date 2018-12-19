#Petit script pour tester si cela peut tourner en boucle juste pour un site web
#zf181219.1719

time_page() {
    label=$1
    url=$2

    ztime=`date +%Y%m%d.%H%M%S-%N`
    zt1=`date +%s.%N`
    docker exec -it docker-firefox /bin/bash /root/work/test1.sh
    zt2=`date +%s.%N`
    zduree=`jq -n $zt2-$zt1`
    echo -e $ztime" "$zduree

    t=$zduree
    #  t=$(echo "2000 + $RANDOM % 3000" | bc)
    c=$(echo "$RANDOM % 2" | bc)
    cat <<__EOF | curl --data-binary @- http://localhost:9091/metrics/job/zuzuresenti/instance/$label
        # TYPE zuzu_resenti_load_time gauge
        zuzu_resenti_load_time $t
        # TYPE zuzu_resenti_page_changed gauge
        zuzu_resenti_page_changed $c
__EOF
}

while true ; do
  time_page "epflhome"  "https://www.epfl.ch/"
#  time_page "enac"  "https://www.epfl.ch/schools/enac/"
  sleep 10
done


