#Petit script pour faire une copie d'écran d'une page web avec firefox en mode headless
#zf190214.1627

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax: ./screenshot.sh url image\n\n"
    exit
fi

#efface le cache de Firefox
rm -rf /root/.cache/

#efface la config de Firefox
#rm -rf /root/.mozilla/

zpath="/root/work/images"
mv $zpath/$2.t1.png $zpath/$2.t0.png 2>/dev/null

instance="ressenti_epfl_firefox_siipc6"

sync
sync
sleep 1
zt1=`date +%s.%N`
firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
zt2=`date +%s.%N`
zduree=`echo "scale=4;$zt2-$zt1" |bc`
#echo -e "étallonage:" $zduree
zoverlay=$zduree
/root/work/send_prometheus.sh $instance overlay $zoverlay 1

sync
sync
sleep 1
zt1=`date +%s.%N`
timeout 31 firefox -headless -screenshot $zpath/$2.t1.png $1 2>/dev/null
zt2=`date +%s.%N`
chmod 777 $zpath/$2.t1.png 2>/dev/null
zduree=`echo "scale=4;($zt2-$zt1-$zoverlay)*0.90" |bc`
if [ `echo "$zduree<0"|bc` -eq 1 ]; then
	zduree=`echo "scale=4;$zt2-$zt1" |bc`
fi

echo -e $zduree
# > duree.txt


