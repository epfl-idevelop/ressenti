#Petit script pour faire une copie d'écran d'une page web avec firefox en mode headless
#zf181220.1359

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax: ./screenshot.sh url image\n\n"
    exit
fi

#efface le cache de Firefox
rm -rf .cache/

zpath="/root/work/images"
mv $zpath/$2.t1.png $zpath/$2.t0.png 2>/dev/null

zt1=`date +%s.%N`
firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
#echo -e "1er shot:" $zduree

zt1=`date +%s.%N`
firefox -headless -screenshot about-blank.png about:blank 2>/dev/null
zt2=`date +%s.%N`
zduree=`jq -n $zt2-$zt1`
#echo -e "2e shot:" $zduree
zoverlay=$zduree

zt1=`date +%s.%N`
firefox -headless -screenshot $zpath/$2.t1.png $1 2>/dev/null
zt2=`date +%s.%N`

chmod 777 $zpath/$2.t1.png

zduree=`jq -n $zt2-$zt1-$zoverlay`

echo -e $zduree
# > duree.txt


