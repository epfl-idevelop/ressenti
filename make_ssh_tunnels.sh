#Petit script pour creuser facilement les tunnels ssh nécessaires ;-)
#zf190214.1546

#exporte au container le port 9891
ssh -f -N -g -L 9991:localhost:9891 localhost

