#Petit script pour faire une copie d'écran d'une page web avec firefox en mode headless
#ATTENTION, il DOIT tourner DANS le container docker-ressenti !
#zf190424.1725

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax: ./screenshot.sh url image\n\n"
    exit
fi



echo "url: "$1
echo "image: "$2

zpath="/root/work/images"





mv $zpath/$2.t1.png $zpath/$2.t0.png







#2>/dev/null

#echo -e "on vide les caches.................."
rm -rf /root/.cache/

#echo -e "on tire en vrai....................."
timeout 31 firefox -screenshot $zpath/$2.t1.png $1 
#2>/dev/null
chmod 777 $zpath/$2.t1.png 
#2>/dev/null

