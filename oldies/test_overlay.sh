#Petit script pour tester les overlay du chargement du browser firefox en mode headless
#zf181221.1441

#efface le cache de Firefox
rm -rf /root/.cache/

zpath="/root/work/images"
mv $zpath/$2.t1.png $zpath/$2.t0.png 2>/dev/null

zt1=`date +%s.%N`
firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
echo -e "1er shot:" $zduree

zt1=`date +%s.%N`
firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
echo -e "2e shot:" $zduree
zoverlay=$zduree

#zt1=`date +%s.%N`
#timeout 31 firefox -headless -screenshot $zpath/$2.t1.png $1 2>/dev/null
#zt2=`date +%s.%N`

#chmod 777 $zpath/$2.t1.png 2>/dev/null

zduree=`jq -n 1-2`

if [ $zduree -lt 0 ]; then
        echo -e "C'est <0"
	zduree=0
fi


echo -e $zduree
# > duree.txt


