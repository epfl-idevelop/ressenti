#Petit script pour faire une copie d'écran d'une page web avec firefox en mode headless
#zf181220.1014

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax: ./screenshot.sh url image\n\n"
    exit
fi




#time stamp du test
#ztime=`date +%Y%m%d.%H%M%S-%N`

#mkdir -p ./poubelle/$ztime
#cd ./poubelle/$ztime


#zt1=`date +%s.%N`

zpath="/root/work/images"
firefox -headless -screenshot $zpath/$2 $1
chmod 777 $zpath/$2


#zt2=`date +%s.%N`

#zduree=`jq -n $zt2-$zt1`

#rm -Rf test*

#echo -e $ztime" "$zduree
# > duree.txt


