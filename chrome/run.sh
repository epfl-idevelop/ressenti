#!/bin/sh
# Check that we are running on a screen
if [ -z "$STY" ] ; then
  echo "Starting resenti on 'resenti'"
  screen -d -m -S "resenti" /bin/bash $0
  exit
fi

ODIR=run_out

[ -d $ODIR ] || mkdir $ODIR

# ./resenti.sh -t 30 -l epfl_chrome -o $ODIR \
#   www.epfl.ch::https://www.epfl.ch/

./resenti.sh -t 120 -l epfl_chrome -o $ODIR \
  z.zufferey.com::http://z.zufferey.com/ \
  www.epfl.ch::https://www.epfl.ch \
  www.epfl.ch-wp-admin::https://www.epfl.ch/wp-admin \
  actu.epfl.ch::https://actu.epfl.ch \
  memento.epfl.ch::https://memento.epfl.ch \
  people.epfl.ch::https://people.epfl.ch/christian.zufferey \
  gel.epfl.ch::https://gel.epfl.ch \
  jahia.epfl.ch::https://jahia.epfl.ch \
  www.abcm.ch-wp::http://www.abcm.ch/wp \
  www.makerspace-lausanne.ch::http://www.makerspace-lausanne.ch \
  | tee -a $ODIR/resenti.log



