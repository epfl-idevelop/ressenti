
#Petit script pour arrêter le binz
#ATTENTION: faire tourner dans le host du container docker-ressenti!

#zf190424.1746

pkill -9 -f '/usr/bin/python tst_flask/async_ressenti.py'
pkill -9 -f '/usr/bin/python ./tst_flask/async_ressenti.py'

