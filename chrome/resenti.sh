#!/bin/bash

OUTDIR="out"
LOCATION="epfl_chrome"
PROMIP="siipc6.epfl.ch:9091"
TINT=300
IMGD=0

die() {
  echo "$*" >&2
}

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

# #       1                   2           3              4             5           6               7
# # zsend $PROMIP             $LOCATION   $label         $load_time    $img_diff   $largest_file   $elements_count
# # zsend siipc6.epfl.ch:9091 epfl_chrome z.zufferey.com 0.089         0           12345           12
# zsend() {
#     cat <<__EOF | curl --data-binary @- http://$1/metrics/job/resenti_$2/instance/$3
#         # TYPE resenti_load_time gauge
#         resenti_load_time {location="$2"} $4
#         # TYPE resenti_page_changed gauge
#         resenti_page_similar {location="$2"} $5
#         # TYPE resenti_largest_file gauge
#         resenti_largest_file {location="$2"} $6
#         # TYPE resenti_elements_count gauge
#         resenti_elements_count {location="$2"} $7
# __EOF
# }

myrand() {
    local max=$((32768 / $1 * $1))
    while (( (r=$RANDOM) >= max )); do :; done
    r=$(( r % $1 ))
    echo $r
}

randomise() {
  b=""
  a=( $@ )
  n=$#
  while [ $n -gt 0 ] ; do 
    i=$(myrand $n)
    b="$b ${a[$i]}"
    unset "a[$i]"
    a=( ${a[@]} )
    let n=$n-1
  done
  echo $b
}

usage() {
  cat <<-__EOF

    Time loading of web pages

    Usage: $0 [-h] [-b] [-d] [-p IP:port] [-t TIME] [LABEL::]URL [[LABEL::]URL] [[LABEL::]URL]...

    Flags:
      -h             Show usage and exit
      -b             Rebuild the container before running it
      -d             Report also image difference
      -l LOCATION    Set prometheus pushgateway job name to resenti_LOCATION [default=$LOCATION]
      -o DIRNAME     Set output directory [default=$OUTDIR]
      -p IP:port     Zuzu's prometheus server address [default=$PROMIP]
      -t TIME        Scan all sites every TIME seconds [default=$TINT]
__EOF
}

while getopts ":bdhl:o:p:t:"  OPT; do
  [[ $OPTARG =~ ^- ]] && die "Option -$OPT requires an argument."
  case $OPT in
    :)
      die "Option -$OPTARG requires an argument."; ;;
    \?)
      usage
      die "Unrecognized flag $OPTARG"; ;;
    h)
      usage; exit; ;;
    b)
      docker build -t webcapture ./docker ;;
    d)
      IMGD=1 ; ;;
    l)
      LOCATION=$OPTARG ; ;;
    o)
      OUTDIR=$OPTARG ; ;;
    p)
      PROMIP=$OPTARG ; ;;
    t)
      TINT=$OPTARG ; ;;
  esac
done
shift $((OPTIND-1))

[ -d $OUTDIR ] || mkdir $OUTDIR || die "Could not create output $(realpath $OUTDIR) directory"
[ -n "$(docker image ls -q webcapture)" ] || die "Docker image webcapture not found. Please add option -b or build with 'docker build -t webcapture ./docker'"

let i=0
let j=0
while true ; do
  t0=$(date +%s)

  ndir="$OUTDIR/res_$i"
  odir="$OUTDIR/res_$j"
  j=$i
  let i=($i+1)%2
  [ -d $ndir ] || mkdir $ndir || die "Could not create $ndir"
  rm -f $odir/*

  # Run all the tests in randomised order
  urls="$(randomise $@)"
  echo "Calling webcapture with out dir $ndir for $urls"

  # node app/multiple_capture.js $ndir $urls
  docker run --user 1000:1000 -v $(realpath $ndir):/tmp/capture webcapture capture.js /tmp/capture $urls

  for logfile in $ndir/*.log ; do
    label=$(basename $logfile .log)
    # load_time=$(awk '/requestStart/{rs=$2; next;}/domComplete/{dc=$2; next;}END{print((dc-rs)/1000.0);}' $logfile)
    load_time=$(awk '{gsub(",", "");}/"duration":/{print($2/1000.0); exit 0;}' $logfile)
    largest_file=$(awk 'BEGIN{smax=0;}{gsub(",", "");}/"transferSize":/{s=$2; smax=s>smax?s:smax;}END{print(smax);}' $logfile)
    elements_count=$(egrep "name|entryType" $logfile | sed 'N;s/\n/ /' | grep '"resource"' | wc -l)
    png1=$ndir/$label.png
    png2=$ndir/$label.png
    if [ -f $png1 -a -f $png2 -a $IMGD -eq 1 ] ; then
      img_diff=$(compare -metric MSE $png1 $png2 /dev/null 2>&1 | awk '{gsub(/[()]/, ""); print $2;}')
    else
      img_diff=0
    fi
    # zsend starts to have too many args. It's easier to embed it here...
    cat <<-____EOF | curl --data-binary @- http://$PROMIP/metrics/job/resenti_$LOCATION/instance/$label
        # TYPE resenti_load_time gauge
        resenti_load_time {location="$LOCATION"} $load_time
        # TYPE resenti_page_changed gauge
        resenti_page_similar {location="$LOCATION"} $img_diff
        # TYPE resenti_largest_file gauge
        resenti_largest_file {location="$LOCATION"} $largest_file
        # TYPE resenti_elements_count gauge
        resenti_elements_count {location="$LOCATION"} $elements_count
____EOF

  done

  let dt=$(date +%s)-$t0
  let wt=$TINT-$dt
  if [ $wt -gt 0 ] ; then
    echo "Scrap took $dt seconds. Sleeping $wt seconds"
    sleep $wt
  else
    echo "Scrap took $dt seconds (more than $TINT). No need to sleep!"
  fi
done