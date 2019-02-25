#Petit script pour creuser facilement les tunnels ssh nécessaires ;-)
#zf19025.1610

#exporte le port 9891 de la VM au port 9991 afin que le container puisse l'utiliser en appelant l'adresse IP externe de la VM
ssh -f -N -g -L 9991:localhost:9891 localhost

