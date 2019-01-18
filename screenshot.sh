#Petit script pour faire une copie d'écran d'une page web avec firefox en mode headless
#zf190115.1807

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


#sync
#sync
#sleep 1
#zt1=`date +%s.%N`
#firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
#zt2=`date +%s.%N`
#zduree=`jq -n $zt2-$zt1`
#echo -e "1er shot à blanc:" $zduree

sync
sync
sleep 1
zt1=`date +%s.%N`
firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
#echo -e "1er shot:" $zduree

sync
sync
sleep 1
zt1=`date +%s.%N`
firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
#echo -e "2e shot:" $zduree
zoverlay=$zduree

sync
sync
sleep 1
zt1=`date +%s.%N`
timeout 31 firefox -headless -screenshot $zpath/$2.t1.png $1 2>/dev/null
zt2=`date +%s.%N`
chmod 777 $zpath/$2.t1.png 2>/dev/null

zduree=`jq -n $zt2-$zt1-$zoverlay`
if [ `echo "$zduree<0"|bc` -eq 1 ]; then
	zduree=0
fi

echo -e $zduree
# > duree.txt


