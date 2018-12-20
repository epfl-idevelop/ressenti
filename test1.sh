#Petit script pour tester juste la durée d'une page 
#zf181220.1128

#time stamp du test
ztime=`date +%Y%m%d.%H%M%S-%N`

zt1=`date +%s.%N`
echo -e "www.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://www.epfl.ch www.epfl.ch
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
echo -e $ztime" "$zduree

zt1=`date +%s.%N`
echo -e "gel.epfl.ch"
    docker exec -it docker-firefox /bin/bash /root/work/screenshot.sh https://gel.epfl.ch gel.epfl.ch
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
echo -e $ztime" "$zduree

